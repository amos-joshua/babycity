import 'package:flutter/material.dart';
//import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'places.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

const niceLocation = LatLng(43.70212, 7.26706);

class PlaceMap extends StatelessWidget {
  final void Function(Place) onTapPlace;
  final List<Place> places;

  const PlaceMap({required this.places, required this.onTapPlace, super.key});

  Widget build(BuildContext context) {
      return FlutterMap(
        options: const MapOptions(
          initialCenter: niceLocation,
          initialZoom: 15,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
            tileProvider: CancellableNetworkTileProvider(),
          ),
          MarkerLayer(
            markers: places.map((place) => Marker(
              point: place.location,
              height: 80,
              width: 80,
              child: IconButton(
                icon: Icon(Icons.place, color: Colors.blue.shade700, size: 48),
                onPressed: () {
                  onTapPlace(place);
                }
              ),
            )
            ).toList(growable: false)
          ),
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
          ),
        ],
      );
  }
}
