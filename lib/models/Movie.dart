class Movie {
  Movie({this.title, this.image});

  String title;
  String image;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json['title'],
        image: 'https://image.tmdb.org/t/p/w500' + json['poster_path']
    );
  }
}