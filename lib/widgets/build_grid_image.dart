import 'package:flutter/material.dart';
import 'package:pextquest/models/photo.dart';
import 'package:pextquest/widgets/build_image.dart';

class BuildGridOfImages extends StatelessWidget {
  const BuildGridOfImages({
    super.key,
    required this.photos,
    required this.controller,
  });

  final List<Photo> photos;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        controller: controller,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return BuildImage(photo: photos[index]);
        },
        itemCount: photos.length,
      ),
    );
  }
}
