import 'package:flutter/material.dart';
import 'sample_data.dart';
import 'movie_detail_screen.dart'; 

class HomeScreen extends StatelessWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sampleMovies.length,
        itemBuilder: (context, index){
          final movie = sampleMovies[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(8),
              leading: Image.network(
                movie.posterUrl,
                width: 60,
                height: 90,
                fit: BoxFit.cover,
              ),

              title: Text(movie.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Rating: ${movie.rating}'),
              trailing: const Icon(Icons.chevron_right),

              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => MovieDetailScreen(movie: movie))
                );
              }
            ),
          );
        },
      ),
    );
  }
}