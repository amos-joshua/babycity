import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'places.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceCard extends StatelessWidget {
  final Place place;

  const PlaceCard(this.place, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          ListTile(
            title: Text(place.name, textScaler: const TextScaler.linear(2.0),),
            trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: place.placeType.map(
                        (type) => Tooltip(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        message: "$type".replaceFirst("PlaceType.", ""),
                        child: Place.typeIcon(type))
                ).toList(growable: false)
            ),
          ),
          ListTile(title: Text(place.description)),
          ListTile(title: Text("Amenities: ${place.amenities.join(", ")}")),
          ListTile(
              title: Text(place.address, style: const TextStyle(fontStyle: FontStyle.italic)),
              trailing: IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: place.address));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('copied'), duration: Duration(milliseconds: 100),));
                },
              )
          ),
          if (place.website != null) ListTile(title: Text(place.website!, style: TextStyle(color: Colors.blue)), onTap: () => launchUrl(Uri.parse(place.website!))),
        ]
    );
  }

  static Future<void> showAsModal(BuildContext context, Place place) {
    return showModalBottomSheet(context: context, builder: (dialogContext) {
      return PlaceCard(place);
    });

  }


}