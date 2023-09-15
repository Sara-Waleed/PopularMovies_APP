import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  MovieDetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            if (movie.posterPath != null)
              Image.network(
                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                fit: BoxFit.cover,
                height: 250,
                width: double.infinity,
              ),

            SizedBox(height: 16),
            Text('Film Name : ${movie.title}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.star_border_outlined),
                SizedBox(width: 10,),
                 Text('6.9',style: TextStyle(fontSize: 18,)),
                SizedBox(width:105),
                Text('Review : 10/8/2023 ',style: TextStyle(fontSize: 18,)),
              ],
            ),
            SizedBox(height: 16),

            Text('OverView',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue)),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              color: Colors.grey[200],
              height: 200,
              child: Text(
                movie.overview,
                style: TextStyle(fontSize: 16,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}