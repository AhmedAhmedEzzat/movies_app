// movie.dart
class Movie {
  final int id;
  final String title;
  final int? year;
  final double? rating;
  final int? runtime;
  final List<String>? genres;
  final String backgroundImage;
  final String mediumCover;
  final String largeCover;
  final String? summary;
  final String descriptionFull;
  final int dateUploadedUnix;


  Movie({
    required this.id,
    required this.title,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    required this.backgroundImage,
    required this.mediumCover,
    required this.largeCover,
    this.summary,
    required this.descriptionFull,
    required this.dateUploadedUnix,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      year: json['year'],
      rating: (json['rating'] is num) ? (json['rating'] as num).toDouble() : null,
      runtime: json['runtime'],
      genres: json['genres'] != null ? List<String>.from(json['genres']) : [],
      backgroundImage: json['background_image'] ?? '',
      mediumCover: json['medium_cover_image'] ?? '',
      largeCover: json['large_cover_image'] ?? '',
      summary: json['summary'],
      descriptionFull: json['description_full'] ?? (json['summary'] ?? ''),
      dateUploadedUnix: json['date_uploaded_unix'] ?? 0,
    );
  }
}
