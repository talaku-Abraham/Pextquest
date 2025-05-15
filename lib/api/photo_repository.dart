import 'package:pextquest/models/photo.dart';

abstract class PhotoService {
  // Future<Photo> fetchPhoto();
  Future<PhotoListResponse> fetchPhotos(int page);
  Future<PhotoListResponse> fetchPhotosByKeyword(String query, int page);
  Future<Photo> getPhotoById(int id);
}
