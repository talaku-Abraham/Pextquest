import 'package:pextquest/models/photo.dart';

abstract class PhotoService {
  Future<Photo> fetchPhoto();
  Future<List<Photo>> fetchPhotos();
}
