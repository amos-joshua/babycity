
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
//import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

enum PlaceType {
  cafe, restaurant
}

class Place {
  final String name;
  final LatLng location;
  final String description;
  final String address;
  final List<PlaceType> placeType;
  final List<String> amenities;
  final String? website;

  Place({required this.name, required this.location, required this.address, required this.description, required this.placeType, required this.amenities, this.website});

  static Icon typeIcon(PlaceType type) {
    switch(type) {
      case PlaceType.cafe: return const Icon(Icons.local_cafe);
      case PlaceType.restaurant: return const Icon(Icons.restaurant);
    }
  }
}

class PlaceRegistry {
  PlaceRegistry();

  final places = [
    Place(
        name: "Atelier Alfred",
        location: const LatLng(43.70719, 7.26161),
        address: "13 Rue Vernier, 06000 Nice",
        description: "Cafe associatif",
        placeType: [PlaceType.cafe],
        amenities: ["Changing table"],
        website: "https://www.atelier-alfred.fr"
    ),
    Place(
        name: "Gare de Sud (Mediterraneo)",
        location: const LatLng(43.70945181378277, 7.261816867360608),
        address: "35 avenue Malaussena, 06000 Nice",
        description: "Food court",
        placeType: [PlaceType.cafe, PlaceType.restaurant],
        amenities: ["Changing table (women's bathroom)"],
        website: "https://mediterraneo-nice.com/"
    ),
    Place(
      name: "L’insolent Café",
      location: const LatLng(43.699297339073816, 7.263516875161304),
      address: "26 Bd Victor Hugo, 06000 Nice",
      description: "Café",
      placeType: [PlaceType.cafe],
      amenities: ["Changing table"],
      website: "https://www.facebook.com/sudnice.fr/"
    )
  ];

  Place? placeFor({required LatLng location}) {
    return places.cast<Place?>().firstWhere((element) => element?.location == location, orElse: () => null);
  }
}