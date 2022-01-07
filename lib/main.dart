import 'package:flutter/material.dart';
import 'package:mileage_tracker/TripList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WorkSafeBC Mileage Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WorkSafeBC Mileage Tracker'),
        ),
        body: const TripList(),
      ),
    );
  }
}
