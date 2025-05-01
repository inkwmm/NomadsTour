import 'package:flutter/material.dart';

import 'blog_screen.dart';
import 'categories_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // количество вкладок
      child: Scaffold(
        appBar: AppBar(
          title: Text('NomadsTour'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Категории'),
              Tab(text: 'Рекомендации'),
              Tab(text: 'Insta-блог'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CategoriesScreen(), // экран категорий
            RecommendationsScreen(), // экран рекомендаций
            BlogScreen(), // экран блога
          ],
        ),
      ),
    );
  }
}

// Экраны внутри вкладок:

class RecommendationsScreen extends StatelessWidget {
  final List<Map<String, String>> recommendedPlaces = [
    {
      'title': 'Жидебай — культурное сердце Казахстана',
      'region': 'Абайская область',
    },
    {
      'title': 'Пещера Коныр-Аулие — духовное место',
      'region': 'Абайская область',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recommendedPlaces.length,
      itemBuilder: (context, index) {
        final place = recommendedPlaces[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
            onTap: () {
              // Здесь можно будет сделать переход на страницу места
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place['title']!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        place['region']!,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
