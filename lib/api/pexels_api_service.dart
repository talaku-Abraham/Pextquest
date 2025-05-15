import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pextquest/api/photo_repository.dart';
import 'package:pextquest/core/env.dart';
import 'package:pextquest/models/photo.dart';

class PexelsApiService implements PhotoService {
  // @override
  // Future<Photo> fetchPhoto() async {
  //   final response = await http.get(
  //     Uri.parse("https://api.pexels.com/v1/curated"),
  //     headers: {"Authorization": Env.apiKey},
  //   );

  //   if (response.statusCode == 200) {
  //     return Photo.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  //   } else {
  //     throw Exception("failed to load Photo");
  //   }
  // }

  @override
  Future<PhotoListResponse> fetchPhotos(int page) async {
    int perPage = 15;
    final response = await http.get(
      Uri.parse(
        "https://api.pexels.com/v1/curated?page=${page}per_page=$perPage",
      ),
      headers: {"Authorization": Env.apiKey},
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      return PhotoListResponse.fromJson(result);
    } else {
      throw Exception("Failed to load photos");
    }
  }

  @override
  Future<PhotoListResponse> fetchPhotosByKeyword(String query, int page) async {
    final response = await http.get(
      Uri.parse("https://api.pexels.com/v1/search?query=$query; page=$page "),
      headers: {"Authorization": Env.apiKey},
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      return PhotoListResponse.fromJson(result);

      // final photos = pics.map((pic) => Photo.fromJson(pic)).toList();

      // if (photos.isEmpty) {
      //   // return fetchPhotos();
      // } else {
      //   return photos;
      // }
    }
    //  else if (response.statusCode == 400 || response.statusCode == 0) {
    //   // return fetchPhotos();
    // }
    else {
      throw Exception("failed to load photos by keyword");
    }
  }

  @override
  Future<Photo> getPhotoById(int id) async {
    final response = await http.get(
      Uri.parse("https://api.pexels.com/v1/photos/$id"),
      headers: {"Authorization": Env.apiKey},
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return Photo.fromJson(result);
    } else {
      throw Exception("unable to find the picture");
    }
  }
}
