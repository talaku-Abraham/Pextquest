import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pextquest/provider/photo_provider.dart';
import 'package:pextquest/widgets/build_grid_image.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final photosProvider = context.watch<PhotoProvider>();

    return photosProvider.favoritePhotos.isEmpty
        ? Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                // Default style for all TextSpan children unless overridden
                fontSize: 25,
                color: Colors.black, // Default text color
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "Looks like your favorites list is empty! Start adding some to see them ",
                ),
                TextSpan(
                  text: 'here',
                  style: TextStyle(
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          context.push("/");
                        },
                ),
              ],
            ),
          ),
        )
        : BuildGridOfImages(photos: photosProvider.favoritePhotos);
  }
}
