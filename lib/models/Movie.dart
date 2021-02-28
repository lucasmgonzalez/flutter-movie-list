class Movie {
  Movie({this.id, this.title, this.image, this.release_date, this.overview});

  int id;
  String title;
  String image;
  String release_date;
  String overview;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        title: json['title'],
        image: 'https://image.tmdb.org/t/p/w500' + json['poster_path'],
        release_date: json['release_date'],
        overview: json['overview']
        //backdrop_path
        //genre_ids
    );
  }
}