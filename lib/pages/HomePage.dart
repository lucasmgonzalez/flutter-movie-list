import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:teste/pages/MoviePage.dart';
import 'package:teste/models/Movie.dart';

Future<List<Movie>> fetchUpcomingMovies() async{
  Map<String, String> queryParams = {
    'api_key': env['TMDB_API_KEY']
  };

  var uri = Uri.https("api.themoviedb.org", '3/movie/upcoming', queryParams);

  var response = await http.get(uri);

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    List<dynamic> results = data['results'];

    List<Movie> movieList = results.map((movieData) {
      return Movie.fromJson(movieData);
    }).toList();

    return movieList;
  } else {
    throw Exception('Failed to load movies');
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Movie>> futureMovieList;

  void initState() {
    super.initState();
    this.futureMovieList = fetchUpcomingMovies();
  }

  Widget buildMovieListGrid(List<Movie> movieList) {
    return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 6/9,
        children: movieList.map((movie) {
          return Container(
            child: FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MoviePage(movie: movie)));
                },
                padding: EdgeInsets.all(4),
                child: Image.network(movie.image, fit: BoxFit.cover)
            ),
          );
        }).toList()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Upcoming Movies'),
        ),
        body: FutureBuilder<List<Movie>>(
          future: futureMovieList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return this.buildMovieListGrid(snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          }
        )
    );
  }
}