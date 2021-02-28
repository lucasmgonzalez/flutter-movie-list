import 'package:teste/models/Movie.dart' as MovieModel;
import 'package:teste/tmdb/API.dart';

class Movie extends API {
  Future<List<MovieModel.Movie>> upcoming() async {
    var data = await this.get('3/movie/upcoming');
    List<dynamic> results = data['results'];

    List<MovieModel.Movie> movieList = results.map((movieData) {
      return MovieModel.Movie.fromJson(movieData);
    }).toList();

    return movieList;
  }
}