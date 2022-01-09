
import 'package:flutter/cupertino.dart';
import 'package:mileage_tracker/DataTypes/trip.dart';
import 'package:intl/intl.dart';

class TripListItem extends StatelessWidget {
  final Trip _trip;
  String _date;
 // String test = DateFormat.yMMMEd()

  TripListItem(Trip trip):
    _trip = trip,
    _date = DateFormat.yMMMd().format(trip.getDate());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(_trip.getStartAddress()),
            Text(_trip.getEndAddress()),
          ],
        ),
        const Spacer(),
        Column(
          children: [
            Text(_date),
            Text(_trip.calcTripDistance().toString()),
          ],
        ),
      ],
    );
  }
}