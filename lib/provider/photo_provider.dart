import 'package:flutter/material.dart';
import 'package:pextquest/api/photo_repository.dart';
import 'package:pextquest/core/db/db_service.dart';
import 'package:pextquest/models/photo.dart';

class PhotoProvider with ChangeNotifier {
  final PhotoService apiService;
  final DataBaseService dataBaseService;

  PhotoProvider({required this.apiService, required this.dataBaseService});

  int homePageNumber = 1;
  int searchPageNumber = 1;

  String searchKeyword = "";

  bool searchScreen = false;

  //hold fetched images from the api
  List<Photo> _photos = [];
  // hold favorite photos
  List<Photo> favoritePhotos = [];
  //store the favorite ids of photos
  List<int> favoritePhotoIds = [];

  bool isLoading = false;
  // setter for the _photos
  set photos(List<Photo> photos) {
    _photos = photos;
    notifyListeners();
  }

  // getter for the _photos
  List<Photo> get photos => _photos;

  // call the api and store the result photos in the _photos
  Future<void> loadPhotos() async {
    // if (isLoading) return;
    isLoading = true;
    // notifyListeners();
    try {
      final response = await apiService.fetchPhotos(homePageNumber);

      if (response.nextPage != null) {
        homePageNumber++;
        // print(homePageNumber);
      }

      _photos.addAll(response.photos!);

      // get list of the favorite pic ids from the database to mark then as favorite
      favoritePhotoIds = await _getFavoritePicIds();
      for (var pic in _photos) {
        if (favoritePhotoIds.contains(pic.photoId)) {
          pic.isFavorite = true;
        }
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<List<int>> _getFavoritePicIds() async {
    return await dataBaseService.getFavoritePhotoIds();
  }

  Future<void> getFavoritePhotos() async {
    isLoading = true;

    notifyListeners();

    favoritePhotos.clear();

    // fetch the ids from the db
    favoritePhotoIds = await _getFavoritePicIds();

    // get each photo and add them to favoriteList notifylistners
    // apiService.getPhotoWithId()

    for (var id in favoritePhotoIds) {
      final photo = await apiService.getPhotoById(id);
      if (!favoritePhotos.contains(photo)) {
        favoritePhotos.add(photo.copyWith(isFavorite: true));
      }
    }
    isLoading = false;

    notifyListeners();
  }

  void toggleFavorite(Photo photo) {
    photo.isFavorite = !photo.isFavorite;

    if (photo.isFavorite) {
      //call the insert method from the database
      dataBaseService.insertPhoto(photo.toMap());
      notifyListeners();
    } else {
      // call the remove method from the database
      dataBaseService.deletePhoto(photo.photoId);
      notifyListeners();
    }
  }

  Future<void> searchPhotoByKeyWord() async {
    isLoading = true;
    // notifyListeners();

    final result = await apiService.fetchPhotosByKeyword(
      searchKeyword,
      searchPageNumber,
    );

    // _photos.clear();
    _photos.addAll(result.photos!);

    /* since i only store the photo id in db the method fetch the
     photos from the api so must update the isFavorite property
    */

    if (result.nextPage != null) {
      searchPageNumber++;
    }

    for (var pic in _photos) {
      if (favoritePhotoIds.contains(pic.photoId)) {
        pic.isFavorite = true;
      }
    }

    isLoading = false;
    notifyListeners();
  }
}
