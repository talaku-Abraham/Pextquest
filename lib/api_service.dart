import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pextquest/models/photo.dart';

Future<Photo> fetchPhoto() async {
  final response = await http.get(
    Uri.parse(
      "https://api.pexels.com/v1/curated",
      // "https://api.pexels.com/v1/photos/2014423"
    ),
    headers: {
      "Authorization":
          "4nEqulsngRjTCfXCUEqYmuSBoH0t6HlVAwSwqZ2vEnfnnpN1P6VifNK5",
    },
  );

  if (response.statusCode == 200) {
    return Photo.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception("failed to load Photo");
  }
}

Future<List<Photo>> fetchPhotos() async {
  final response = await http.get(
    Uri.parse("https://api.pexels.com/v1/curated"),
    headers: {
      "Authorization":
          "4nEqulsngRjTCfXCUEqYmuSBoH0t6HlVAwSwqZ2vEnfnnpN1P6VifNK5",
    },
  );

  final List<dynamic> pics;

  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);

    pics = result["photos"];

    return pics.map((json) {
      return Photo.fromJson(json);
    }).toList();
  } else {
    throw Exception("Failed to load photos");
  }
}
