import 'package:flutter/material.dart';

import '../data/place_data.dart';
import 'blog_screen.dart';
import 'categories_screen.dart';
import 'place_detail_screen.dart';

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
          children: [CategoriesScreen(), RecommendationsScreen(), BlogScreen()],
        ),
      ),
    );
  }
}

class RecommendationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recommendedPlaces = places.take(3).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Рекомендации'), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: recommendedPlaces.length,
        itemBuilder: (context, index) {
          final place = recommendedPlaces[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlaceDetailScreen(place: place),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(place.image, fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          place.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          place.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
