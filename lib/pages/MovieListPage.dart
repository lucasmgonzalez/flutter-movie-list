import 'package:flutter/material.dart';
import 'package:teste/pages/MoviePage.dart';
import 'package:teste/models/Movie.dart';
import 'package:teste/tmdb/Trending.dart';
import 'package:teste/tmdb/Movie.dart' as MovieAPI;

class MovieListPage extends StatefulWidget {
  MovieListState createState() => MovieListState();
}

class MovieListState extends State<MovieListPage> {
  MovieListState({this.selectedPageIndex = 0});

  int selectedPageIndex;
  Future<List<Movie>> futureMovieList;

  List<Map<String, dynamic>> pageOptions = [
    {
      'title': 'Upcoming Movies',
      'fetcher': MovieAPI.Movie().upcoming,
      'navigation': {
        'label': 'Upcoming',
        'icon': Icon(Icons.movie)
      },
    },
    {
      'title': 'Trending Movies Today',
      'fetcher': () => Trending().fetchMovies(timeWindow: 'day'),
      'navigation': {
        'label': 'Trending Today',
        'icon': Icon(Icons.movie)
      },
    },
    {
      'title': 'Trending Movies this week',
      'fetcher': () => Trending().fetchMovies(timeWindow: 'week'),
      'navigation': {
        'label': 'Trending Week',
        'icon': Icon(Icons.movie)
      },
    }
  ];

  void initState() {
    super.initState();
    this.futureMovieList = pageOptions.elementAt(selectedPageIndex)['fetcher']();
  }

  void handleTabChange(int index) {
    setState(() {
      selectedPageIndex = index;
      futureMovieList = pageOptions.elementAt(index)['fetcher']();
    });
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

  Widget build(BuildContext context){
    var selectedPage = pageOptions[selectedPageIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPage['title']),
      ),
      body: FutureBuilder<List<Movie>>(
          future: futureMovieList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return this.buildMovieListGrid(snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return Center(child: CircularProgressIndicator());
          }
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: pageOptions.map((pageOption) {
            var navigation = pageOption['navigation'];
            return BottomNavigationBarItem(icon: navigation['icon'], label: navigation['label']);
          }).toList(),
          currentIndex: selectedPageIndex,
          selectedItemColor: Colors.blue[500],
          onTap: handleTabChange
      ),
    );
  }
}