class PhotoListResponse {
  int? perPage;
  String? nextPage;
  String? prevPage;

  List<Photo>? photos;

  PhotoListResponse({this.nextPage, this.perPage, this.photos, this.prevPage});

  factory PhotoListResponse.fromJson(Map<String, dynamic> json) {
    List<Photo> tempPhotos;
    tempPhotos = [];

    if (json['photos'] != null) {
      json['photos'].forEach((v) {
        tempPhotos.add(Photo.fromJson(v));
      });
    }

    return PhotoListResponse(
      nextPage: json["next_page"],
      perPage: json["per_page"],
      prevPage: json["prev_page"],
      photos: tempPhotos,
    );
  }
}

class Photo {
  final int photoId;
  final int width;
  final int height;
  final Src src;
  int likes;
  bool isFavorite;

  Photo({
    required this.photoId,
    required this.width,
    required this.height,
    required this.src,
    this.isFavorite = false,
    this.likes = 0,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      photoId: json["id"],
      width: json["width"],
      height: json["height"],
      src: Src.fromJson(json["src"]),
      likes: json["like"] ?? 0,
      isFavorite: false,
    );
  }

  Map<String, Object?> toMap() {
    return {'photoId': photoId};
  }

  Photo copyWith({int? likes, bool? isFavorite}) {
    return Photo(
      photoId: photoId,
      width: width,
      height: height,
      src: src,
      likes: likes ?? this.likes,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  String toString() {
    return "Photo(photoId:$photoId, width:$width , height: $height , src: $src)";
  }
}

class Src {
  final String original;
  final String large;
  final String landscape;

  Src({required this.original, required this.large, required this.landscape});

  factory Src.fromJson(Map<String, dynamic> json) {
    return Src(
      original: json["original"],
      large: json["large"],
      landscape: json["landscape"],
    );
  }

  @override
  String toString() {
    return "Src(origin:$original , large:$large , landscape:$landscape)";
  }
}
