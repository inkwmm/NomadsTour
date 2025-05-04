import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nomads_tour/data/Blog_data.dart';

import 'blog_detail_screen.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Блог')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;
          final posts =
              docs.map((doc) => BlogPost.fromMap(doc.data())).toList();

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return ListTile(
                leading: Image.network(
                  post.imageUrl,
                  width: 60,
                  fit: BoxFit.cover,
                ),
                title: Text(post.title),
                subtitle: Text(post.summary),
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlogDetailScreen(post: post),
                      ),
                    ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddPostScreen()),
            ),
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final summaryController = TextEditingController();
  final contentController = TextEditingController();
  XFile? image;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => image = picked);
  }

  Future<void> submit() async {
    if (image == null) return;

    final storageRef = FirebaseStorage.instance.ref().child(
      'blog/${image!.name}',
    );
    final uploadTask = await storageRef.putFile(File(image!.path));
    final imageUrl = await storageRef.getDownloadURL();

    final post = BlogPost(
      title: titleController.text,
      author: authorController.text,
      summary: summaryController.text,
      content: contentController.text,
      imageUrl: imageUrl,
    );

    await FirebaseFirestore.instance.collection('posts').add(post.toMap());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Добавить пост')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Заголовок'),
            ),
            TextField(
              controller: summaryController,
              decoration: InputDecoration(labelText: 'Краткое описание'),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Текст статьи'),
              maxLines: 6,
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: pickImage,
              icon: Icon(Icons.image),
              label: Text(
                image == null ? 'Выбрать изображение' : 'Изображение выбрано',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: submit, child: Text('Опубликовать')),
          ],
        ),
      ),
    );
  }
}
