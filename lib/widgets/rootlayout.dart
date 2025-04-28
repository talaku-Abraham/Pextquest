import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pextquest/provider/photo_provider.dart';
import 'package:provider/provider.dart';

class Rootlayout extends StatelessWidget {
  const Rootlayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final photoProvider = context.read<PhotoProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Pextquest"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_outline_rounded, size: 30),
            onPressed: () {
              photoProvider.getfavoritePhotos();
              context.push("/favorite");
            },
          ),
          Icon(Icons.search),
        ],
      ),
      body: child,
    );
  }
}
