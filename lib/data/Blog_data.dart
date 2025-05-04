class BlogPost {
  final String title;
  final String author;
  final String summary;
  final String content;
  final String imageUrl;

  BlogPost({
    required this.title,
    required this.author,
    required this.summary,
    required this.content,
    required this.imageUrl,
  });

  factory BlogPost.fromMap(Map<String, dynamic> data) {
    return BlogPost(
      title: data['title'],
      author: data['author'],
      summary: data['summary'],
      content: data['content'],
      imageUrl: data['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'summary': summary,
      'content': content,
      'imageUrl': imageUrl,
    };
  }
}
