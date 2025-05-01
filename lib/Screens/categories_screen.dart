import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'title': 'Культурно-познавательный туризм', 'value': 'culture'},
    {'title': 'Экологический туризм', 'value': 'eco'},
    {'title': 'Горный туризм', 'value': 'mountain'},
    {'title': 'Религиозный туризм', 'value': 'religious'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Категории туризма')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(category['title']!),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Здесь позже сделаем переход на список мест
                  Navigator.pushNamed(
                    context,
                    '/places',
                    arguments: category['value'],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
