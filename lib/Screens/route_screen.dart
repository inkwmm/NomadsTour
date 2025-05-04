import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../data/place_data.dart';

class RouteScreen extends StatefulWidget {
  final Place place;

  const RouteScreen({super.key, required this.place});

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  List<LatLng> roadRoute = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRoadRoute();
  }

  Future<void> fetchRoadRoute() async {
    final regionCenter = getRegionCenter(widget.place.region);
    final destination = LatLng(widget.place.latitude, widget.place.longitude);

    const apiKey = '5b3ce3597851110001cf6248438adc3334084fde94224ac09fe688bf';
    final url =
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=${regionCenter.longitude},${regionCenter.latitude}&end=${destination.longitude},${destination.latitude}';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final coords = data['features'][0]['geometry']['coordinates'];

      setState(() {
        roadRoute = coords.map<LatLng>((c) => LatLng(c[1], c[0])).toList();
        isLoading = false;
      });
    } else {
      print('Ошибка при загрузке маршрута: ${response.body}');
    }
  }

  LatLng getRegionCenter(String region) {
    switch (region) {
      case 'Абайская':
        return LatLng(49.8034, 82.6998);
      case 'Алматинская':
        return LatLng(43.439753608575, 76.98799006287493);
      // Добавь свои регионы
      default:
        return LatLng(48.0196, 66.9237);
    }
  }

  @override
  Widget build(BuildContext context) {
    final regionCenter = getRegionCenter(widget.place.region);

    return Scaffold(
      appBar: AppBar(title: Text('Маршрут к ${widget.place.name}')),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : FlutterMap(
                options: MapOptions(center: regionCenter, zoom: 6),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.nomads_tour',
                  ),
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: roadRoute,
                        color: Colors.blue,
                        strokeWidth: 5,
                      ),
                    ],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: regionCenter,
                        width: 40,
                        height: 40,
                        child: Icon(Icons.location_city, color: Colors.red),
                      ),
                      Marker(
                        point: LatLng(
                          widget.place.latitude,
                          widget.place.longitude,
                        ),
                        width: 40,
                        height: 40,
                        child: Icon(Icons.place, color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
    );
  }
}

LatLng getRegionCenter(String regionName) {
  switch (regionName) {
    case 'Алматинская область':
      return LatLng(43.2220, 76.8512);
    case 'Астана':
      return LatLng(51.1605, 71.4704);
    case 'Абайская область':
      return LatLng(50.4111, 80.2278);
    default:
      return LatLng(48.0196, 66.9237); // центр Казахстана
  }
}
