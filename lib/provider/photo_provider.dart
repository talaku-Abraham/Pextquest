import 'package:flutter/material.dart';
import 'package:pextquest/api/photo_repository.dart';
import 'package:pextquest/models/photo.dart';

class PhotoProvider with ChangeNotifier {
  final PhotoService apiService;

  PhotoProvider({required this.apiService});

  // fetched iages from the api
  List<Photo> _photos = [];

  List<Photo> favoritePhotos = [];

  bool isLoading = false;

  // get the images
  List<Photo> get photos => _photos;

  // get a single photo by photoid
  Photo photo(int id) => _photos.firstWhere((pic) => pic.photoId == id);

  // call the api and store the result photos in the _photos
  Future<void> loadPhotos() async {
    isLoading = true;
    notifyListeners();

    _photos = await apiService.fetchPhotos();

    isLoading = false;
    notifyListeners();
  }

  void toggleFavorite(int photoId) {
    var resultIndex = _photos.indexWhere((pic) => pic.photoId == photoId);
    if (resultIndex != -1) {
      var result = _photos[resultIndex];
      var updatedPhoto = result.copyWith(
        likes: 3,
        isFavorite: !result.isFavorite,
      );
      _photos[resultIndex] = updatedPhoto;

      notifyListeners();
    }
  }

  void getfavoritePhotos() {
    favoritePhotos = _photos.where((pic) => pic.isFavorite == true).toList();

    notifyListeners();
  }
}
