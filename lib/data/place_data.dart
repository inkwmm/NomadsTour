class Place {
  final String id;
  final String name;
  final String region;
  final double regionLatitude;
  final double regionLongitude;
  final String description;
  final String category;
  final List<Map<String, dynamic>> tours;
  final List<Map<String, dynamic>> hotels;
  final List<Map<String, dynamic>> cafes;
  final double latitude;
  final double longitude;
  final String image;

  Place({
    required this.id,
    required this.name,
    required this.region,
    required this.regionLatitude,
    required this.regionLongitude,
    required this.description,
    required this.category,
    required this.tours,
    required this.hotels,
    required this.cafes,
    required this.latitude,
    required this.longitude,
    required this.image,
  });
}

final List<Place> places = [
  Place(
    id: '1',
    name: 'Жидебай, заповедник',
    region: 'Абайская область',
    regionLatitude: 43.238949,
    regionLongitude: 76.889709,
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
    latitude: 51.1694,
    longitude: 71.4491,
    image: 'assets/images/zhidebay.jpg',
  ),
  Place(
    id: '2',
    name: 'Коныр-Аулие',
    region: 'Абайская область',
    regionLatitude: 43.238949,
    regionLongitude: 76.889709,
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
    latitude: 47.8117,
    longitude: 78.3739,
    image: 'assets/images/konyr-aulie.webp',
  ),
  Place(
    id: '3',
    name: 'Чарынский каньон',
    region: 'Алматинская область',
    regionLatitude: 43.238949,
    regionLongitude: 76.889709,
    description:
        'Чарынский каньон сформировался около 12 миллионов лет назад из осадочных пород.',
    category: 'eco',
    tours: [
      {
        'title': 'Однодневный тур от KZ Sky',
        'date': '5-7 августа',
        'price': 6500,
      },
    ],
    hotels: [
      {'name': 'Эко-парк', 'contact': '8 (7222) 32-17-01', 'price': 44000},
    ],
    cafes: [
      {'name': 'Эко-парк', 'rating': 10, 'price': 300},
    ],
    latitude: 43.36314953826513,
    longitude: 79.04998070276436,
    image: 'assets/images/charyn canyon.jpg',
  ),
];
