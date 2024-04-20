import 'package:babycity/place_card.dart';
import 'package:babycity/places.dart';
import 'package:flutter/material.dart';

class PlaceListView extends StatelessWidget {
  final PlaceRegistry places;

  const PlaceListView({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Places"),
      ),
      body: ListView(
        children: places.places.map((place) => ListTile(
          title: Text(place.name),
          subtitle: Text(place.address),
          onTap: () => PlaceCard.showAsModal(context, place),
        )).toList(growable: false)
      ),
    );
  }

}