import 'package:flutter/material.dart';
import 'sample_data.dart'; 

class MovieDetailScreen extends StatelessWidget{
  final Movie movie;
  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  movie.posterUrl,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                )
              ],
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 100,
                padding: const EdgeInsets.all(16),
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black
                    ]
                  ),
                ),
                child: Text(
                  movie.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 8.0, 
                runSpacing: 4.0,
                children: movie.genres.map((genre) {
                  return Chip(
                    label: Text(genre),
                    backgroundColor: Colors.grey.shade200,
                  );
                }).toList(),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                movie.overview,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIconAction(Icons.favorite_border, 'Favorite'),
                _buildIconAction(Icons.star_border, 'Rate'),
                _buildIconAction(Icons.share, 'Share'),
              ],
            ),
            const SizedBox(height: 24),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Trailers',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),

            ListView.builder(
              shrinkWrap: true, 
              physics: const NeverScrollableScrollPhysics(), 
              itemCount: movie.trailers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.play_circle_fill, size: 36),
                  title: Text(movie.trailers[index]),
                );
              },
            ),
            const SizedBox(height: 32),
          ],  
        ),
      )
    );
  }

  Widget _buildIconAction(IconData icon, String label){
    return Column(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(icon, size: 28)
        ),
        Text(label, style: const TextStyle(fontSize: 14))
      ],
    );
  }
}