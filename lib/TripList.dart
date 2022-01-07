import 'package:flutter/material.dart';

class TripList extends StatefulWidget {
  const TripList({Key? key}) : super(key: key);

  @override
  State<TripList> createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  List<String> _trips = <String>['abc', 'cde'];
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _trips.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(_trips[index]);
      }
    );
  }
}