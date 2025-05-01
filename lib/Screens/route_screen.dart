import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class RouteScreen extends StatelessWidget {
  final List<LatLng> routePoints;

  RouteScreen({required this.routePoints});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Маршрут')),
      body: Center(child: Text('Скачай и используй без интернета!')),
    );
  }
}
