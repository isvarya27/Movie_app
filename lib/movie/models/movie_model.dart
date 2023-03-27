class MovieResponseModels {
  MovieResponseModels({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  factory MovieResponseModels.fromJson(Map<String, dynamic> json) {
    return MovieResponseModels(
      page: json["page"],
      results: json["results"] == null
          ? []
          : List<MovieModel>.from(
              json["results"]!.map((x) => MovieModel.fromJson(x)),
            ),
      totalPages: json["total_pages"],
      totalResults: json["total_results"],
    );
  }
}

class MovieModel {
  MovieModel({
    this.backdropPath,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final int id;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final DateTime? releaseDate;
  final String title;
  final double voteAverage;
  final int voteCount;

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      backdropPath: json["backdrop_path"] ?? '',
      id: json["id"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      popularity: double.parse(json["vote_average"].toString()),
      posterPath: json["poster_path"] ?? '',
      releaseDate: DateTime.tryParse(json["release_date"] ?? ""),
      title: json["title"],
      voteAverage: double.parse(json["vote_average"].toString()),
      voteCount: json["vote_count"],
    );
  }
}
