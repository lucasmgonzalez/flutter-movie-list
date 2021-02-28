import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:teste/models/Movie.dart';

class MoviePage extends StatelessWidget {
  MoviePage({this.movie});

  Movie movie;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(movie.title),
        ),
        body: Column(
            children: [
              Container(padding: EdgeInsets.all(8),child: Image.network(movie.image)),
              Text(movie.title)
            ],
        )
    );
  }
}