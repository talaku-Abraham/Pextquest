import 'package:flutter/material.dart';
import 'package:pextquest/api/pexels_api_service.dart';
import 'package:pextquest/widgets/build_image.dart';
import 'package:pextquest/provider/photo_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pextquest"),
        actions: [
          Icon(Icons.search, size: 30),
          Icon(Icons.favorite_outline_rounded),
        ],
      ),

      body: MultiProvider(
        providers: [
          Provider<PexelsApiService>(create: (context) => PexelsApiService()),
          ChangeNotifierProvider<PhotoProvider>(
            create:
                (context) =>
                    PhotoProvider(apiService: context.read<PexelsApiService>()),

            // context.read<ApiService>()
          ),
        ],
        child: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final photoProvider = context.read<PhotoProvider>();
      // Load photos if they are not loaded yet
      if (!photoProvider.isLoading && photoProvider.photos.isEmpty) {
        photoProvider.loadPhotos();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final photoProvider = context.watch<PhotoProvider>();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child:
            photoProvider.isLoading
                ? CircularProgressIndicator()
                : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return BuildImage(photo: photoProvider.photos[index]);
                  },
                  itemCount: photoProvider.photos.length,
                ),
      ),
    );
  }
}
