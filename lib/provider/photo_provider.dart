import 'package:flutter/material.dart';
import 'package:pextquest/api/photo_repository.dart';
import 'package:pextquest/models/photo.dart';
import 'dart:collection';

class PhotoProvider with ChangeNotifier {
  final PhotoService apiService;

  PhotoProvider({required this.apiService});

  // fetched images from the api
  List<Photo> _photos = [];

  List<Photo> favoritePhotos = [];

  List<int> favoritePhotoIds = [];

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

  Future<void> searchByKeyWord(String keyword) async {
    isLoading = true;
    notifyListeners();

    _photos = await apiService.fetchPhotosByKeyword(keyword);

    for (int i = 0; i < _photos.length; i++) {
      for (int j = 0; j < favoritePhotos.length; j++) {
        if (_photos[i].photoId == favoritePhotos[j].photoId) {
          _photos[i].isFavorite = favoritePhotos[j].isFavorite;
          print("true talex");
          notifyListeners();
        }
      }

      // final index = _photos.indexWhere(
      //   (element) => element.photoId == photo.photoId,
      // );

      // _photos[index].isFavorite = photo.isFavorite;
      // notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }

  void toggleFavorite(Photo photo) {
    // var resultIndex = _photos.indexWhere((pic) => pic.photoId == photoId);
    // if (resultIndex != -1) {
    //   var result = _photos[resultIndex];
    //   var updatedPhoto = result.copyWith(
    //     likes: 3,
    //     isFavorite: !result.isFavorite,
    //   );
    //   _photos[resultIndex] = updatedPhoto;
    photo.isFavorite = !photo.isFavorite;

    if (favoritePhotos.any((pic) => pic.photoId == photo.photoId)) {
      favoritePhotos.remove(photo);
      notifyListeners();
    } else {
      favoritePhotos.add(photo);
      notifyListeners();
    }

    // if (_photos.contains(photo) && favoritePhotos.contains(photo)) {
    //   favoritePhotos.remove(photo);
    //   notifyListeners();
    // } else if (_photos.contains(photo) && !favoritePhotos.contains(photo)) {

    // }

    // var photo = _photos.firstWhere((pic) => pic.photoId == photoId);

    notifyListeners();
  }

  // void getfavoritePhotos() {
  //   // favoritePhotos = _photos.where((pic) => pic.isFavorite == true).toList();

  //   notifyListeners();
  // }
}
