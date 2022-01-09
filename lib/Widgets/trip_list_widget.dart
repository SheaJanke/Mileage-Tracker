import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mileage_tracker/DataTypes/trip_list.dart';
import 'package:mileage_tracker/Widgets/trip_list_item.dart';

class TripListWidget extends StatelessWidget {
  final TripList _tripList;

  TripListWidget(this._tripList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _tripList.getNumTrips(),
        itemBuilder: (BuildContext context, int index) {
          return TripListItem(_tripList.getTripAtIndex(index));
        });
  }
}
