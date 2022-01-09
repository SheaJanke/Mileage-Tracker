import 'package:flutter/material.dart';
import 'package:mileage_tracker/DataTypes/trip_reasons.dart';
import 'package:mileage_tracker/Pages/trip_list_page.dart';

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
      home: const TripListPage(),
    );
  }
}
