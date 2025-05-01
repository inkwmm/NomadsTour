import 'package:latlong2/latlong.dart';

class Place {
  final String id;
  final String name;
  final String region;
  final String description;
  final String category;
  final List<Map<String, dynamic>> tours;
  final List<Map<String, dynamic>> hotels;
  final List<Map<String, dynamic>> cafes;
  final List<LatLng> routePoints;

  Place({
    required this.id,
    required this.name,
    required this.region,
    required this.description,
    required this.category,
    required this.tours,
    required this.hotels,
    required this.cafes,
    required this.routePoints,
  });
}

final List<Place> places = [
  Place(
    id: '1',
    name: 'Жидебай, заповедник',
    region: 'Абайская область',
    description: 'Историческое место, где жил и творил Абай Кунанбаев...',
    category: 'culture',
    tours: [
      {'title': 'Тур по Жидебаю', 'date': '5-7 августа', 'price': 70000},
      {
        'title': 'Жидебай + Коныр-Аулие',
        'date': '10-13 августа',
        'price': 85500,
      },
    ],
    hotels: [
      {
        'name': 'База отдыха Елимай',
        'contact': '8 (7222) 32-17-01',
        'price': 13000,
      },
    ],
    cafes: [
      {'name': 'Кафе "Абай"', 'rating': 7, 'price': 300},
    ],
    routePoints: [
      LatLng(51.1694, 71.4491), // примерные точки
      LatLng(50.2820, 77.0736),
    ],
  ),
  Place(
    id: '2',
    name: 'Коныр-Аулие',
    region: 'Абайская область',
    description: '85000',
    category: 'religious',
    tours: [
      {'title': 'Тур по Жидебаю', 'date': '5-7 августа', 'price': 70000},
      {
        'title': 'Жидебай + Коныр-Аулие',
        'date': '10-13 августа',
        'price': 85500,
      },
    ],
    hotels: [
      {
        'name': 'База отдыха Елимай',
        'contact': '8 (7222) 32-17-01',
        'price': 13000,
      },
    ],
    cafes: [
      {'name': 'Кафе "Абай"', 'rating': 7, 'price': 300},
    ],
    routePoints: [
      LatLng(51.1694, 71.4491), // примерные точки
      LatLng(50.2820, 77.0736),
    ],
  ),
  Place(
    id: '3',
    name: 'Чарынский каньон',
    region: 'Алматинская область',
    description: '60000',
    category: 'eco',
    tours: [
      {'title': 'Тур по Жидебаю', 'date': '5-7 августа', 'price': 70000},
      {
        'title': 'Жидебай + Коныр-Аулие',
        'date': '10-13 августа',
        'price': 85500,
      },
    ],
    hotels: [
      {
        'name': 'База отдыха Елимай',
        'contact': '8 (7222) 32-17-01',
        'price': 13000,
      },
    ],
    cafes: [
      {'name': 'Кафе "Абай"', 'rating': 7, 'price': 300},
    ],
    routePoints: [
      LatLng(51.1694, 71.4491), // примерные точки
      LatLng(50.2820, 77.0736),
    ],
  ),
];
