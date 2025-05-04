import 'package:flutter/material.dart';
import 'package:nomads_tour/data/Blog_data.dart';

class BlogDetailScreen extends StatelessWidget {
  final BlogPost post;

  const BlogDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(post.title)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(post.imageUrl),
            SizedBox(height: 16),
            Text(post.content, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
