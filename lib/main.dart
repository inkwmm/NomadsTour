import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/categories_screen.dart';
import 'screens/home_screen.dart';
import 'screens/place_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      },
    );
  }
}
