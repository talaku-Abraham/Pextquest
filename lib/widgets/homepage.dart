import 'package:flutter/material.dart';
import 'package:pextquest/core/infinite_scroll_mixin.dart';
import 'package:pextquest/widgets/build_grid_image.dart';
import 'package:pextquest/provider/photo_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with InfiniteScrollMixin {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final photoProvider = context.read<PhotoProvider>();
      // Load photos if they are not loaded yet
      if (!photoProvider.isLoading
      // && photoProvider.photos.isEmpty
      ) {
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
                : BuildGridOfImages(
                  photos: photoProvider.photos,
                  controller: scrollController,
                ),
      ),
    );
  }

  @override
  void onLoadMore() {
    final photoProvider = context.read<PhotoProvider>();
    if (photoProvider.searchScreen) {
      print("search screen baby");
      photoProvider.searchPhotoByKeyWord();
    } else {
      print("load function called correctly");
      photoProvider.loadPhotos();
    }
  }
}
