class Movie{
  String id;
  String title;
  String posterUrl;
  String overview;
  List<String> genres;
  double rating;
  List<String> trailers;

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.rating,
    required this.overview,
    required this.genres,
    required this.trailers,
  });
}

final List<Movie> sampleMovies = [
  Movie(
    id: 'M001', 
    title: 'Dune: Part Two',
    posterUrl: 'https://photo-baomoi.bmcdn.me/w500_r1/2024_03_03_131_48463429/46699122306ed930807f.jpg', 
    rating: 8.6,
    overview: 'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    trailers: ['Official Trailer #1', 'IMAX Sneak Peek'],
  ),
  Movie(
    id: 'M002',
    title: 'Deadpool & Wolverine',
    posterUrl: 'https://images.squarespace-cdn.com/content/v1/5452d441e4b0c188b51fef1a/3065ca34-d0b0-4c7b-a4aa-b18a29c21dc6/Deadpool+and+wolverine.png',
    rating: 8.3,
    overview: 'The multiverse gets messy when Wade Wilson teams up with Wolverine for a not-so-family-friendly mission.',
    genres: ['Action', 'Comedy'],
    trailers: ['Red Band Trailer', 'Behind the Scenes'],
  ),
];