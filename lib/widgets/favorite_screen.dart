import 'package:flutter/material.dart';
import 'package:pextquest/provider/photo_provider.dart';
import 'package:pextquest/widgets/build_grid_image.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final photosProvider = context.watch<PhotoProvider>();

    return BuildGridOfImages(photos: photosProvider.favoritePhotos);
  }
}
