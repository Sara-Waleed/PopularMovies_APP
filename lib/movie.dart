class Movie {
  final String title;
  final String overview;
  final String posterPath;
  final String originalTitle;

  Movie({
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.originalTitle,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      originalTitle: json['original_title'],
    );
  }
}