import 'package:teste/models/Movie.dart';
import 'package:teste/tmdb/API.dart';

class Trending extends API{
  Future<List<Movie>> fetchMovies({String timeWindow = 'day'}) async{
    var data = await this.get('3/trending/movie/$timeWindow');
    List<dynamic> results = data['results'];

    List<Movie> movieList = results.map((movieData) {
      return Movie.fromJson(movieData);
    }).toList();

    return movieList;
  }
}