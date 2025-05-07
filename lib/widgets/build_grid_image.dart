import 'package:flutter/material.dart';
import 'package:pextquest/models/photo.dart';
import 'package:pextquest/widgets/build_image.dart';

class BuildGridOfImages extends StatelessWidget {
  const BuildGridOfImages({super.key, required this.photos});

  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
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
