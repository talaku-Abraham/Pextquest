import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pextquest/models/photo.dart';
import 'package:pextquest/provider/photo_provider.dart';
import 'package:provider/provider.dart';

class BuildImage extends StatelessWidget {
  const BuildImage({super.key, required this.photo});

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    final photoProvider = context.read<PhotoProvider>();

    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: photo.src.original,
              placeholder:
                  (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Row(
            children: [
              // Icon(Icons.favorite, color: Colors.white),
              // SizedBox(width: 3),
              IconButton(
                onPressed: () {
                  photoProvider.toggleFavorite(photo.photoId);
                },
                icon: Icon(
                  Icons.thumb_up,
                  color: photo.isFavorite ? Colors.red : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
