import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pextquest/provider/photo_provider.dart';
import 'package:provider/provider.dart';
import "package:pextquest/provider/search_field_controller.dart";

class Rootlayout extends StatelessWidget {
  const Rootlayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final photoProvider = context.read<PhotoProvider>();

    final searchController =
        context.read<SearchFieldController>().textEditingController;

    return Scaffold(
      appBar: AppBar(
        title: Text("Pextquest"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_outline_rounded, size: 30),
            onPressed: () {
              // photoProvider.getfavoritePhotos();
              context.push("/favorite");
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              height: 100,

              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a search term',
                ),
                onSubmitted:
                    (value) =>
                        photoProvider.searchByKeyWord(searchController.text),
              ),
            ),
          ),
          // IconButton(icon: Icon(Icons.search), onPressed: () {

          // }),
        ],
      ),
      body: child,
    );
  }
}
