import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart'; // для маршрутов

import 'data/place_data.dart'; // чтобы работал тип Place
import 'screens/blog_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/home_screen.dart';
import 'screens/place_detail_screen.dart';
import 'screens/place_list_screen.dart';
import 'screens/route_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NomadsTour',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/categories': (context) => CategoriesScreen(),
        '/places': (context) => PlacesListScreen(),
        '/blog': (context) => BlogScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/place-detail') {
          final place = settings.arguments as Place;
          return MaterialPageRoute(
            builder: (context) => PlaceDetailScreen(place),
          );
        }

        if (settings.name == '/route') {
          final points = settings.arguments as List<LatLng>;
          return MaterialPageRoute(
            builder: (context) => RouteScreen(routePoints: points),
          );
        }

        return null; // если маршрут не найден
      },
    );
  }
}
