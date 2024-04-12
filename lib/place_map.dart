import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'places.dart';

class PlaceMap extends StatelessWidget {
  final void Function(Place) onTapPlace;
  final List<Place> places;

  PlaceMap({required this.places, required this.onTapPlace, super.key});

  void addMarkers() async {
    for (final place in places) {
      await mapController.addMarker(place.location,
        markerIcon:MarkerIcon(icon: Icon(Icons.location_pin, color: Colors.blue.shade700, size: 32,),),
        angle:0,
      );
    }
  }

  final mapController = MapController(
    initPosition: GeoPoint(latitude: 43.70212, longitude: 7.26706),
    areaLimit: BoundingBox(
      east: 7.3131,
      north: 43.7349,
      south: 43.6276,
      west:  7.1983,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return OSMFlutter(
        controller:mapController,
        onMapIsReady: (ready) {
          if (ready) {
            addMarkers();
          }
        },
        onGeoPointClicked: (geoPoint) {
          final place = places.cast<Place?>().firstWhere((place) => place?.location == geoPoint, orElse: () => null);
          if (place != null) onTapPlace(place);
        },
        osmOption: OSMOption(
          userTrackingOption: const UserTrackingOption(
            enableTracking: true,
            unFollowUser: false,
          ),
          zoomOption: const ZoomOption(
            initZoom: 15,
            minZoomLevel: 13,
            maxZoomLevel: 19,
            stepZoom: 1.0,
          ),
          userLocationMarker: UserLocationMaker(
            personMarker: const MarkerIcon(
              icon: Icon(
                Icons.location_history_rounded,
                color: Colors.red,
                size: 48,
              ),
            ),
            directionArrowMarker: const MarkerIcon(
              icon: Icon(
                Icons.double_arrow,
                size: 48,
              ),
            ),
          ),
          roadConfiguration: const RoadOption(
            roadColor: Colors.yellowAccent,
          ),
        )
    );
  }
}
