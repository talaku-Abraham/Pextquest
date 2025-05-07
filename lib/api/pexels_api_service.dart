import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pextquest/api/photo_repository.dart';
import 'package:pextquest/core/env.dart';
import 'package:pextquest/models/photo.dart';

class PexelsApiService implements PhotoService {
  @override
  Future<Photo> fetchPhoto() async {
    final response = await http.get(
      Uri.parse("https://api.pexels.com/v1/curated"),
      headers: {"Authorization": Env.apiKey},
    );

    if (response.statusCode == 200) {
      return Photo.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception("failed to load Photo");
    }
  }

  @override
  Future<List<Photo>> fetchPhotos() async {
    final response = await http.get(
      Uri.parse("https://api.pexels.com/v1/curated"),
      headers: {"Authorization": Env.apiKey},
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

  @override
  Future<List<Photo>> fetchPhotosByKeyword(String query) async {
    final response = await http.get(
      Uri.parse("https://api.pexels.com/v1/search?query=$query"),
      headers: {"Authorization": Env.apiKey},
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      List<dynamic> pics = result["photos"];

      final photos = pics.map((pic) => Photo.fromJson(pic)).toList();

      if (photos.isEmpty) {
        return fetchPhotos();
      } else {
        return photos;
      }
    } else if (response.statusCode == 400 || response.statusCode == 0) {
      return fetchPhotos();
    } else {
      throw Exception("failed to load photos by keyword");
    }
  }
}
