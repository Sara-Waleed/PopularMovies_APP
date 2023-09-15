import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviesapp/MovieDetailsScreen.dart';
//import 'package:moviesapp/MovieDetailsScreen.dart' show Movie;

// ...
import 'main.dart';
// ...
class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}
class _MovieListScreenState extends State<MovieListScreen> {
  late Future<List<Movie>> _futureMovies;
  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=4363044419b8b102097308192fac3c58'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final moviesData = jsonData['results'] as List<dynamic>;
      List<Movie> movies = moviesData.map((movieData) => Movie.fromJson(movieData)).toList();
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }
  @override
  void initState() {
    super.initState();
    _futureMovies = fetchMovies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Center(
        child: FutureBuilder<List<Movie>>(
          future: _futureMovies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final movie = snapshot.data![index];
                  return Card(
                    child: ListTile(
                      leading: movie.posterPath != null
                          ? Image.network(
                        'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                        fit: BoxFit.cover,
                        width: 50,
                      )
                          : Container(),
                      title: Text(movie.title),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MovieDetailsScreen(movie: movie)),
                        );
                      },
                    ),
                  );
                },
              );
            } else {
              return Text('No movies found');
            }
          },
        ),
      ),
    );
  }
}
