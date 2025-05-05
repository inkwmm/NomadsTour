import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: RouteMapPage()));
}

class RouteMapPage extends StatefulWidget {
  @override
  _RouteMapPageState createState() => _RouteMapPageState();
}

class _RouteMapPageState extends State<RouteMapPage> {
  final LatLng origin = LatLng(43.238949, 76.889709); // Алматы
  final LatLng destination = LatLng(43.353710, 79.068627); // Шарын

  GoogleMapController? mapController;
  Set<Polyline> polylines = {};
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    fetchRoute();
  }

  Future<void> fetchRoute() async {
    final url = Uri.parse(
      "http://localhost:3000/directions?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final points = data["routes"][0]["overview_polyline"]["points"];

      final decodedPoints = PolylinePoints().decodePolyline(points);

      final polylineCoordinates =
          decodedPoints.map((p) => LatLng(p.latitude, p.longitude)).toList();

      setState(() {
        polylines.add(
          Polyline(
            polylineId: PolylineId("route"),
            color: Colors.blue,
            width: 5,
            points: polylineCoordinates,
          ),
        );

        markers.addAll([
          Marker(markerId: MarkerId("origin"), position: origin),
          Marker(markerId: MarkerId("destination"), position: destination),
        ]);
      });
    } else {
      print("Ошибка при получении маршрута");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Маршрут")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: origin, zoom: 8),
        onMapCreated: (controller) => mapController = controller,
        polylines: polylines,
        markers: markers,
      ),
    );
  }
}
