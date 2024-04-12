import "package:flutter/material.dart";
import "place_map.dart";
import "places.dart";
import 'place_card.dart';

class MainPage extends StatefulWidget {
  final title = 'Baby Friendly Venues in Nice';
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MainPage> {
  final places = PlaceRegistry();
  var placeSelected = false;

  void onPlaceTapped(Place place) async {
    setState(() {
      placeSelected = true;
    });
    await PlaceCard.showAsModal(context, place);
    setState(() {
      placeSelected = false;
    });
  }

  Future<void> showAbout() async {
    setState(() {
      placeSelected = true;
    });
    await showDialog(context: context, builder: (dialogContext) => const AboutDialog(
      applicationName: "Baby City - Nice",
      children: [
        Text("Made by Amos & Amelia Joshua")
      ],
    ));
    setState(() {
      placeSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: showAbout,
              icon: const Icon(Icons.info)
          )
        ],
      ),
      body:
      Visibility(
        visible: !placeSelected,
        maintainAnimation: true,
        maintainState: true,
        child: PlaceMap(
          places: places.places,
          onTapPlace: onPlaceTapped
        )
      )
    );
  }

}