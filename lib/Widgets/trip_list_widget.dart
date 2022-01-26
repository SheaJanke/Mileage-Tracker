import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mileage_tracker/DataTypes/trip_list.dart';
import 'package:mileage_tracker/Pages/trip_list_page.dart';
import 'package:mileage_tracker/Widgets/trip_list_item.dart';

class TripListWidget extends StatelessWidget {
  final TripList _tripList;
  final UpdateTripIndexFunction _updateTripIndex;

  const TripListWidget(
      {Key? key,
      required TripList tripList,
      required UpdateTripIndexFunction updateTripIndex})
      : _tripList = tripList,
        _updateTripIndex = updateTripIndex,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _tripList.getNumTrips(),
      itemBuilder: (BuildContext context, int index) {
        return TripListItem(
          trip: _tripList.getTripAtIndex(index),
          updateTrip: _updateTripIndex(index),
        );
      },
    );
  }
}
