import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../data/place_data.dart';

class RouteMapPage extends StatefulWidget {
  final Place place;

  const RouteMapPage({super.key, required this.place});

  @override
  _RouteMapPageState createState() => _RouteMapPageState();
}

class _RouteMapPageState extends State<RouteMapPage> {
  late LatLng origin;
  late LatLng destination;

  GoogleMapController? mapController;
  Set<Polyline> polylines = {};
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();

    origin = LatLng(widget.place.regionLatitude, widget.place.regionLongitude);
    destination = LatLng(widget.place.latitude, widget.place.longitude);

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
      print("Ошибка при получении маршрута: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Маршрут до ${widget.place.name}")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: origin, zoom: 8),
        onMapCreated: (controller) => mapController = controller,
        polylines: polylines,
        markers: markers,
      ),
    );
  }
}
