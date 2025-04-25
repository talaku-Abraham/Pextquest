import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pextquest/api_service.dart';
import 'package:pextquest/models/photo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Home(),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Photo>> futurePhoto;

  @override
  void initState() {
    super.initState();

    futurePhoto = fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
          future: futurePhoto,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return BuildImage(
                    imageUrl: snapshot.data![index].src.original,
                  );
                },
                itemCount: snapshot.data!.length,
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class BuildImage extends StatelessWidget {
  const BuildImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder:
                  (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(bottom: 0, left: 0, child: Buttons()),
      ],
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Icon(Icons.favorite, color: Colors.white),
          SizedBox(width: 10),
          Icon(Icons.thumb_up, color: Colors.white),
        ],
      ),
    );
  }
}
