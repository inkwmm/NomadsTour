import 'package:flutter/material.dart';
import 'package:nomads_tour/Screens/route_screen.dart';

import '../data/place_data.dart';

class PlaceDetailScreen extends StatelessWidget {
  final Place place;

  const PlaceDetailScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.name)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Регион
            Text(
              place.region,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 12),

            // История
            Text('История', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8),
            Text(place.description),
            SizedBox(height: 24),

            // Туры
            Text(
              'Доступные туры',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8),
            ...place.tours.map((tour) => TourTile(tour)),
            SizedBox(height: 24),

            // Гостиницы
            Text(
              'Гостиницы рядом',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8),
            ...place.hotels.map((hotel) => HotelTile(hotel)),
            SizedBox(height: 24),

            // Кафе
            Text(
              'Кафе поблизости',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8),
            ...place.cafes.map((cafe) => CafeTile(cafe)),
            SizedBox(height: 40),

            // Кнопка "Маршрут"
            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.map),
                label: Text('Показать маршрут'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RouteScreen(place: place),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TourTile extends StatelessWidget {
  final Map<String, dynamic> tour;
  const TourTile(this.tour);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.tour),
      title: Text(tour['title']),
      subtitle: Text('Дата: ${tour['date']}'),
      trailing: Text('${tour['price']} ₸'),
    );
  }
}

class HotelTile extends StatelessWidget {
  final Map<String, dynamic> hotel;
  const HotelTile(this.hotel);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.hotel),
      title: Text(hotel['name']),
      subtitle: Text(hotel['contact']),
      trailing: Text('${hotel['price']} ₸'),
    );
  }
}

class CafeTile extends StatelessWidget {
  final Map<String, dynamic> cafe;
  const CafeTile(this.cafe);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.restaurant),
      title: Text(cafe['name']),
      subtitle: Text('Оценка: ${cafe['rating']}/10'),
      trailing: Text('${cafe['price']} ₸'),
    );
  }
}
