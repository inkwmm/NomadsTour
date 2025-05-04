import 'package:flutter/material.dart';

import '../data/place_data.dart';
import 'place_detail_screen.dart';

class PlacesListScreen extends StatefulWidget {
  @override
  _PlacesListScreenState createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  late String selectedCategory;
  String selectedRegion = 'Все';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as String?;
    selectedCategory = args ?? 'all';
  }

  List<String> get allRegions {
    final regions =
        places
            .where(
              (p) =>
                  p.category == selectedCategory || selectedCategory == 'all',
            )
            .map((place) => place.region)
            .toSet()
            .toList();
    regions.sort();
    return regions;
  }

  List<Place> get filteredPlaces {
    return places.where((p) {
      final categoryMatch =
          selectedCategory == 'all' || p.category == selectedCategory;
      final regionMatch = selectedRegion == 'Все' || p.region == selectedRegion;
      return categoryMatch && regionMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Места')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: DropdownButton<String>(
              value: selectedRegion,
              isExpanded: true,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedRegion = value;
                  });
                }
              },
              items: [
                DropdownMenuItem(value: 'Все', child: Text('Все области')),
                ...allRegions.map(
                  (region) =>
                      DropdownMenuItem(value: region, child: Text(region)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPlaces.length,
              itemBuilder: (context, index) {
                final place = filteredPlaces[index];
                return ListTile(
                  title: Text(place.name),
                  subtitle: Text('${place.region} — ${place.description}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaceDetailScreen(place: place),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
