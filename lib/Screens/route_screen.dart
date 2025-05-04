import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:latlong2/latlong.dart';

class RouteScreen extends StatefulWidget {
  final LatLng start;
  final LatLng end;

  const RouteScreen({required this.start, required this.end, super.key});

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  List<LatLng> polylinePoints = [];

  final String googleApiKey = 'AIzaSyA7ENpBpwrOCSKAzj7Wv7CsprD5sdRJCfg';

  @override
  void initState() {
    super.initState();
    getRoute();
  }

  Future<void> getRoute() async {
    PolylinePoints polylinePointsTool = PolylinePoints();

    final result = await polylinePointsTool.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(widget.start.latitude, widget.start.longitude),
      PointLatLng(widget.end.latitude, widget.end.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      setState(() {
        polylinePoints =
            result.points.map((e) => LatLng(e.latitude, e.longitude)).toList();
      });
    } else {
      print("Не удалось получить маршрут: ${result.errorMessage}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Маршрут")),
      body: FlutterMap(
        options: MapOptions(center: widget.start, zoom: 10),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 40,
                height: 40,
                point: widget.start,
                child: const Icon(Icons.location_on, color: Colors.green),
              ),
              Marker(
                width: 40,
                height: 40,
                point: widget.end,
                child: const Icon(Icons.flag, color: Colors.red),
              ),
            ],
          ),
          if (polylinePoints.isNotEmpty)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: polylinePoints,
                  strokeWidth: 4,
                  color: Colors.blue,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
