import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveMovieApp());
}

class Movie{
  String title;
  int year;
  List<String> genres;
  String posterUrl;
  double rating; 

  Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

final List<Movie> allMovies = [
  Movie(
    title: 'Dune: Part Two',
    year: 2024,
    genres: ['Action', 'Adventure', 'Sci-Fi'],
    posterUrl: 'https://photo-baomoi.bmcdn.me/w500_r1/2024_03_03_131_48463429/46699122306ed930807f.jpg',
    rating: 8.6,
  ),
  Movie(
    title: 'Deadpool & Wolverine',
    year: 2024,
    genres: ['Action', 'Comedy'],
    posterUrl: 'https://images.squarespace-cdn.com/content/v1/5452d441e4b0c188b51fef1a/3065ca34-d0b0-4c7b-a4aa-b18a29c21dc6/Deadpool+and+wolverine.png',
    rating: 8.3,
  ),
  Movie(
    title: 'Oppenheimer',
    year: 2023,
    genres: ['Biography', 'Drama', 'History'],
    posterUrl: 'https://img.youtube.com/vi/uYPbbksJxIg/maxresdefault.jpg',
    rating: 8.4,
  ),
  Movie(
    title: 'Spider-Man: Across the Spider-Verse',
    year: 2023,
    genres: ['Animation', 'Action', 'Adventure'],
    posterUrl: 'https://i.pinimg.com/736x/8e/a6/43/8ea6431c8e80a26d234b7f91c9a7af41.jpg',
    rating: 8.7,
  ),
  Movie(
    title: 'The Dark Knight',
    year: 2008,
    genres: ['Action', 'Crime', 'Drama'],
    posterUrl: 'https://images-na.ssl-images-amazon.com/images/I/81IfoBox2TL.jpg',
    rating: 9.0,
  ),
];

final List<String> availableGenres = [
  'Action', 'Adventure', 'Sci-Fi', 'Comedy', 
  'Biography', 'Drama', 'History', 'Animation', 'Crime'
];

class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive Movie Layout',
      theme: ThemeData(
        brightness: Brightness.light, 
        primarySwatch: Colors.blue,
      ),
      home: const GenreScreen(),
    );
  }
}

  class GenreScreen extends StatefulWidget {
  const GenreScreen({Key? key}) : super(key: key);

  @override
  State<GenreScreen> createState() => _GenreScreenState();
  } 

  class _GenreScreenState extends State<GenreScreen> {
    String searchQuery = '';
    Set<String> selectedGenres = {};
    String selectedSort = 'A-Z';

    @override
    Widget build(BuildContext context) {
      List<Movie> visibleMovies = allMovies.where((movie) {
      final matchesSearch = movie.title.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesGenre = selectedGenres.isEmpty || movie.genres.any((g) => selectedGenres.contains(g));
      return matchesSearch && matchesGenre;
    }).toList();

    visibleMovies.sort((a, b) {
      switch (selectedSort) {
        case 'A-Z':
          return a.title.compareTo(b.title);
        case 'Z-A':
          return b.title.compareTo(a.title);
        case 'Year':
          return b.year.compareTo(a.year); 
        case 'Rating':
          return b.rating.compareTo(a.rating);
        default:
          return 0; 
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề
              const Text('Find a movie', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              // Thanh tìm kiếm
              TextField(
                decoration: InputDecoration(
                  hintText: 'movie name, genre',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),  
              const SizedBox(height: 16),

              // Danh sách thể loại
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('Genres: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      if(selectedGenres.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.rectangle,
                          ),
                          child: Text(
                            selectedGenres.join(', '),
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        ),
                    ]
                  ),
                  if(selectedGenres.isNotEmpty || searchQuery.isNotEmpty)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedGenres.clear();
                          searchQuery = '';
                        });
                      },
                      child: const Text('Clear', style: TextStyle(color: Colors.redAccent)),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: availableGenres.map((genre) {
                  final isSelected = selectedGenres.contains(genre);
                  return FilterChip(
                    label: Text(genre),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedGenres.add(genre);
                        } else {
                          selectedGenres.remove(genre);
                        }
                      });
                    },
                    selectedColor: Colors.blueGrey,
                    checkmarkColor: Colors.white,
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Sort by: '),
                    DropdownButton<String>(
                      value: selectedSort,
                      underline: const SizedBox(),
                      items: ['A-Z', 'Z-A', 'Year', 'Rating'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedSort = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const Divider(),

              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (visibleMovies.isEmpty) {
                      return const Center(child: Text('No movies found.'));
                    }

                    // Nếu màn hình rộng >= 800px (Tablet/Web) -> Dùng GridView 2 cột
                    if (constraints.maxWidth >= 800) {
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 2.5, // Tỷ lệ thẻ trên màn hình rộng
                        ),
                        itemCount: visibleMovies.length,
                        itemBuilder: (context, index) {
                          return _buildMovieCard(visibleMovies[index]);
                        },
                      );
                    } 
                    // Nếu màn hình hẹp (< 800px) (Điện thoại) -> Dùng ListView 1 cột
                    else {
                      return ListView.builder(
                        itemCount: visibleMovies.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: _buildMovieCard(visibleMovies[index]),
                          );
                        },
                      );
                    }
                  },
                )
              )
            ]
          )
        )
      )
    );
  }
  
  // MovieCard
  Widget _buildMovieCard(Movie movie) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poster ảnh
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.network(
              movie.posterUrl,
              width: 100,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),

          // Thông tin chi tiết phim
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Year: ${movie.year}',
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                  const SizedBox(height: 4),
                  // Thêm phần hiển thị sao 
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text('${movie.rating}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Hiển thị một số thể loại của phim
                  Wrap(
                    spacing: 4,
                    children: movie.genres.map((g) => Text(
                      g, 
                      style: const TextStyle(fontSize: 12, color: Colors.blueAccent)
                    )).toList(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

