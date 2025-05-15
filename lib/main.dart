import 'package:flutter/material.dart';
import 'package:pextquest/api/pexels_api_service.dart';
import 'package:pextquest/core/db/db_service.dart';
import 'package:pextquest/provider/photo_provider.dart';
import 'package:pextquest/route.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:pextquest/provider/search_field_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class TestToBeDeleted extends StatelessWidget {
  const TestToBeDeleted({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: ScrollInfiniteTest())),
    );
  }
}

class ScrollInfiniteTest extends StatefulWidget {
  const ScrollInfiniteTest({super.key});

  @override
  State<ScrollInfiniteTest> createState() => _ScrollInfiniteTestState();
}

class _ScrollInfiniteTestState extends State<ScrollInfiniteTest> {
  final ScrollController _scrollController = ScrollController();
  int itemCount = 9;

  bool isLoading = false;

  List<String> items = [];
  @override
  void initState() {
    super.initState();
    _fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        print("reached the end");
        _fetchData();
      }
    });
  }

  void _fetchData() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    final newItems = List.generate(20, (index) => "text $index");

    setState(() {
      items.addAll(newItems);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: items.length,
      itemBuilder: (context, index) {
        // if (index == 50) {
        //   return Center(child: CircularProgressIndicator());
        // }
        return ListTile(title: Text(items[index]));
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PexelsApiService>(create: (context) => PexelsApiService()),
        Provider<DataBaseService>(create: (context) => DataBaseService()),
        ChangeNotifierProvider<SearchFieldController>(
          create: (context) => SearchFieldController(),
        ),

        ChangeNotifierProvider<PhotoProvider>(
          create:
              (context) => PhotoProvider(
                apiService: context.read<PexelsApiService>(),
                dataBaseService: context.read<DataBaseService>(),
              ),

          // context.read<ApiService>()
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
      ),
    );
  }
}
