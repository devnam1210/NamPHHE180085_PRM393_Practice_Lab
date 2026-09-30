import 'package:flutter/material.dart';

class LayoutDemoScreen extends StatelessWidget {
  const LayoutDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> movies = ['Avatar', 'Inception', 'Interstellar', 'Joker'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text('Exercise 3 - Layout Demo'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Căn giữa nội dung
        children: [
          const SizedBox(height: 24),
          const Text(
            'Now Playing',
            style: TextStyle(
              fontSize: 22, 
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), 
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final String movieName = movies[index];
                
                return Card(
                  color: const Color(0xFFF5F5F7),
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 12.0), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo.shade100, 
                      foregroundColor: Colors.indigo.shade900,
                      child: Text(movieName[0]), 
                    ),
                    title: Text(movieName, style: const TextStyle(fontWeight: FontWeight.w500)),
                    subtitle: const Text('Sample description', style: TextStyle(color: Colors.grey)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}