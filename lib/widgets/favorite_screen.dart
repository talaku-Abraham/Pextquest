import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pextquest/core/infinite_scroll_mixin.dart';
import 'package:pextquest/provider/photo_provider.dart';
import 'package:pextquest/widgets/build_grid_image.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with InfiniteScrollMixin {
  Future<void>? _loadFavoritePhotos;
  @override
  void initState() {
    super.initState();

    final photoProvider = context.read<PhotoProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadFavoritePhotos = photoProvider.getFavoritePhotos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final photosProvider = context.watch<PhotoProvider>();

    return FutureBuilder(
      future: _loadFavoritePhotos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return photosProvider.favoritePhotos.isEmpty
            ? Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    // Default style for all TextSpan children unless overridden
                    fontSize: 25,
                    color: const Color.fromARGB(
                      255,
                      220,
                      30,
                      30,
                    ), // Default text color
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          "Looks like your favorites list is empty! Start adding some to see them ",
                      style: TextStyle(color: Colors.black),
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
                              context.pushReplacement("/");
                            },
                    ),
                  ],
                ),
              ),
            )
            : BuildGridOfImages(
              photos: photosProvider.favoritePhotos,
              controller: scrollController,
            );
      },
    );
  }

  @override
  void onLoadMore() {
    // call a function that return me 15 favorite photos every time it get called
  }
}
