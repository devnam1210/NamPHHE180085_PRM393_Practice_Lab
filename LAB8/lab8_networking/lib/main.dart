import 'package:flutter/material.dart';
import 'api_service.dart';
import 'post.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PostListScreen());
  }
}

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Post>> _futurePosts;

  @override
  void initState() {
    super.initState();
    _futurePosts = _apiService.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text('Lab8 Networking'),
      ),
      body: FutureBuilder<List<Post>>(
        future: _futurePosts,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasError) {
            return Center(child: Text('Something went wrong: ${snapshot.error}'));
          }
          else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                return ListTile(
                  leading: CircleAvatar(child: Text(post.id.toString())),
                  title: Text(post.title),
                );
              },
            );
          }
          return const Center(child: Text('No data available'));
        }
      )
    );
  }
}