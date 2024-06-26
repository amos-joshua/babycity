import "package:babycity/place_list_view.dart";
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

  void onPlaceTapped(Place place) async {
    await PlaceCard.showAsModal(context, place);
  }

  Future<void> showAbout() async {
    await showDialog(context: context, builder: (dialogContext) => const AboutDialog(
      applicationName: "Baby City - Nice",
      children: [
        Text("Made in Nice with ❤️\nFor Lily")
      ],
    ));
  }

  Future<void> showList() async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlaceListView(places: places)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: showList,
              icon: const Icon(Icons.list)
          ),
          IconButton(
              onPressed: showAbout,
              icon: const Icon(Icons.info)
          )
        ],
      ),
      //drawer: const AppDrawer(),
      body: PlaceMap(
        places: places.places,
        onTapPlace: onPlaceTapped
      )
    );
  }

}