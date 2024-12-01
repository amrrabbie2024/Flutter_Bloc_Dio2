part of 'bloc.dart';

class VMovieDetailsData {

  late final bool adult;
  late final String backdropPath;
  late final Null belongsToCollection;
  late final int budget;

  late final String homepage;
  late final int id;
  late final String imdbId;
  late final List<String> originCountry;
  late final String originalLanguage;
  late final String originalTitle;
  late final String overview;
  late final double popularity;
  late final String posterPath;

  late final String releaseDate;
  late final int revenue;
  late final int runtime;

  late final String status;
  late final String tagline;
  late final String title;
  late final bool video;
  late final double voteAverage;
  late final int voteCount;

  VMovieDetailsData.fromJson(Map<String, dynamic> json){
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    belongsToCollection = null;
    budget = json['budget'];

    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    originCountry = List.castFrom<dynamic, String>(json['origin_country']);
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];

    releaseDate = json['release_date'];
    revenue = json['revenue'];
    runtime = json['runtime'];

    status = json['status'];
    tagline = json['tagline'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }


}

