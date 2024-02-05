import 'package:dio/dio.dart';
import 'package:osiris/Models/EpisodeDetail.dart';
import 'package:osiris/Models/MovieDetail.dart';
import 'package:osiris/Models/PopularMovies.dart';
import 'package:osiris/Models/SearchResult.dart';
import 'package:osiris/Models/TvShow.dart';
import 'package:osiris/Models/TvShowDetail.dart';
import 'package:osiris/Models/VideoDetails.dart';


class APIService {
  // Dio -> xử lý http
  final Dio _dio = Dio();
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = '22eeb90d1dc4408cfb8400ee918a5c45';

  Future<List<Results>> getPopularMovie() async {
    try {
      List<Results> movieList = [];
      final url = '$baseUrl/movie/popular?api_key=$apiKey&page=1';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      movieList = movies.map((m) => Results.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Results>> getTopRatedMovie() async {
    try {
      List<Results> movieList = [];
      final url = '$baseUrl/movie/top_rated?api_key=$apiKey&page=1';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      movieList = movies.map((m) => Results.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Results>> getNowPLayingMovie() async {
    try {
      List<Results> movieList = [];
      final url = '$baseUrl/movie/now_playing?api_key=$apiKey&page=1';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      movieList = movies.map((m) => Results.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<TvShow>> getPopularShow() async {
    try {
      List<TvShow> showsList = [];
      final url = '$baseUrl/tv/popular?api_key=$apiKey&page=1';
      final response = await _dio.get(url);
      var shows = response.data['results'] as List;
      showsList = shows.map((m) => TvShow.fromJson(m)).toList();
      return showsList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<TvShow>> getTopRatedShow() async {
    try {
      List<TvShow> showsList = [];
      final url = '$baseUrl/tv/top_rated?api_key=$apiKey&page=1';
      final response = await _dio.get(url);
      var shows = response.data['results'] as List;
      showsList = shows.map((m) => TvShow.fromJson(m)).toList();
      return showsList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<SearchResult>> getSearchResult(searchQuery) async {
    if (searchQuery.toString().isEmpty) {
      return [];
    }
    try {
      final url = '$baseUrl/search/multi?api_key=$apiKey&query=$searchQuery';
      final response = await _dio.get(url);
      var shows = response.data['results'] as List;
      List<SearchResult> showsList =
          shows.map((m) => SearchResult.fromJson(m)).toList();
      return showsList;
    } catch (error) {
      return [];
    }
  }

  Future<MovieDetail> getMovieDetail(String movieId) async {
    try {
      final url = '$baseUrl/movie/$movieId?api_key=$apiKey';
      final response = await _dio.get(url);
      MovieDetail movie = MovieDetail.fromJson(response.data);
      return movie;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Genres>> getMovieGenres(String movieId, String mediaType) async {
    try {
      List<Genres> genresList = [];
      final url = '$baseUrl/$mediaType/$movieId?api_key=$apiKey';
      final response = await _dio.get(url);
      var genres = response.data['genres'] as List;
      genresList = genres.map((m) => Genres.fromJson(m)).toList();
      return genresList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Results>> getSimilarMovie(String movieId) async {
    try {
      List<Results> movieList = [];
      final url = '$baseUrl/movie/$movieId/similar?api_key=$apiKey&page=1';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      movieList = movies.map((m) => Results.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Results>> getRecommendedMovie(String movieId) async {
    try {
      List<Results> movieList = [];
      final url = '$baseUrl/movie/$movieId/recommendations?api_key=$apiKey&page=1';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      movieList = movies.map((m) => Results.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<String> getTrailerLink(String movieId, String mediaType) async {
    try {
      final url = '$baseUrl/$mediaType/$movieId/videos?api_key=$apiKey';
      final response = await _dio.get(url);
      var videos = response.data['results'] as List;
      List<VideoResults> videosList =
          videos.map((m) => VideoResults.fromJson(m)).toList();
      var trailerLink = 'dQw4w9WgXcQ'; // default trailer: Rick Roll
      for (var i = 0; i < videosList.length; i++) {
        if (videosList[i].site == 'YouTube' &&
            videosList[i].type == 'Trailer') {
          trailerLink = videosList[i].key.toString();
        }
      }
      return 'https://www.youtube.com/watch?v=$trailerLink';
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<TvShowDetail> getTvShowDetail(String showId) async {
    try {
      final url = '$baseUrl/tv/$showId?api_key=$apiKey';
      final response = await _dio.get(url);
      TvShowDetail show = TvShowDetail.fromJson(response.data);
      return show;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<TvShow>> getSimilarTvShows(String showId) async {
    try {
      List<TvShow> showList = [];
      final url = '$baseUrl/tv/$showId/similar?api_key=$apiKey&page=1';
      final response = await _dio.get(url);
      var shows = response.data['results'] as List;
      showList = shows.map((m) => TvShow.fromJson(m)).toList();
      return showList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<TvShow>> getRecommendedTvShows(String showId) async {
    try {
      List<TvShow> showList = [];
      final url = '$baseUrl/tv/$showId/recommendations?api_key=$apiKey&page=1';
      final response = await _dio.get(url);
      var shows = response.data['results'] as List;
      showList = shows.map((m) => TvShow.fromJson(m)).toList();
      return showList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Episodes>> getEpisodes(String showID, String seasonNum) async {
    try {
      List<Episodes> episodeList = [];
      final url = '$baseUrl/tv/$showID/season/$seasonNum?api_key=$apiKey';
      final response = await _dio.get(url);
      var shows = response.data['episodes'] as List;
      episodeList = shows.map((m) => Episodes.fromJson(m)).toList();
      return episodeList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Results>> getLatestMovie() async {
    try {
      List<Results> movieList = [];
      final url = '$baseUrl/movie/upcoming?api_key=$apiKey&page=1';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      movieList = movies.map((m) => Results.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<TvShow>> getOnAirShows() async {
    try {
      List<TvShow> showList = [];
      final url = '$baseUrl/tv/on_the_air?api_key=$apiKey';
      final response = await _dio.get(url);
      var shows = response.data['results'] as List;
      showList = shows.map((m) => TvShow.fromJson(m)).toList();
      return showList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
}