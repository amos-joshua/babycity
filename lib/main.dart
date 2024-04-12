import 'package:flutter/material.dart';
import 'main_page.dart';

void main() {
  runApp(const BabyCity());
}

class BabyCity extends StatelessWidget {
  const BabyCity({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Baby Friendly Venues in Nice',
      home: MainPage()
    );
  }
}