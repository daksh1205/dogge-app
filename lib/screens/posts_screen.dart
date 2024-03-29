// screens/posts_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ayna_bloc/models/post.dart';
import 'package:ayna_bloc/services/api_service.dart';
import 'package:ayna_bloc/bloc/post_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class PostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts',
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: BlocProvider(
        create: (context) =>
            PostBloc(apiService: ApiService())..add(FetchPosts()),
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PostsLoaded) {
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  Post post = state.posts[index];
                  return ListTile(
                    title: Text(post.title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      post.body,
                    ),
                  );
                },
              );
            }
            if (state is PostsError) {
              return const Center(child: Text('Failed to fetch posts'));
            }
            return Container(); // Initial state
          },
        ),
      ),
    );
  }
}
