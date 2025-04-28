import 'package:flutter/material.dart';
import 'package:pextquest/api/pexels_api_service.dart';
import 'package:pextquest/provider/photo_provider.dart';
import 'package:pextquest/route.dart';
import 'package:pextquest/widgets/homepage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PexelsApiService>(create: (context) => PexelsApiService()),
        ChangeNotifierProvider<PhotoProvider>(
          create:
              (context) =>
                  PhotoProvider(apiService: context.read<PexelsApiService>()),

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
