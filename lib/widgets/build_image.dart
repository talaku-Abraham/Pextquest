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
      // align its unpositioned element to the topleft
      alignment: Alignment.bottomRight,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Icon(Icons.favorite, color: Colors.white),
            // SizedBox(width: 3),
            IconButton(
              onPressed: () {
                photoProvider.toggleFavorite(photo);
                // if (photo.isFavorite) {
                //   databaseProvider.insertPhoto(photo.toMap());
                // }
              },
              icon: Icon(
                Icons.thumb_up,
                color: photo.isFavorite ? Colors.red : Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
