import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mileage_tracker/DataTypes/trip.dart';
import 'package:intl/intl.dart';
import 'package:mileage_tracker/Pages/edit_trip_page.dart';

import '../styles.dart';

class TripListItem extends StatelessWidget {
  final Trip _trip;
  String _date;
  int _distance;

  TripListItem(Trip trip)
      : _trip = trip,
        _date = DateFormat.MMMd().format(trip.getDate()),
        _distance = trip.calcTripDistance();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green.shade800, width: 4),
        color: Colors.green.shade100,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.green.shade300,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditTripPage(trip: _trip)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.play_arrow_rounded),
                          Flexible(
                            child: Text(
                              _trip.getStartAddress(),
                              style: Styles.normalStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.stop_rounded),
                          Flexible(
                            child: Text(
                              _trip.getEndAddress(),
                              style: Styles.normalStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _date,
                      style: Styles.boldStyle,
                    ),
                    Text(
                      "$_distance km",
                      style: Styles.boldStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
