import 'package:flutter/material.dart';
import 'package:mileage_tracker/DataTypes/trip.dart';
import 'package:mileage_tracker/DataTypes/trip_list.dart';
import 'package:mileage_tracker/DataTypes/trip_reasons.dart';
import 'package:mileage_tracker/Widgets/trip_list_widget.dart';
import 'package:mileage_tracker/storage_manager.dart';

class TripListPage extends StatefulWidget {
  const TripListPage({Key? key}) : super(key: key);

  @override
  State<TripListPage> createState() => _TripListPageState();
}

class _TripListPageState extends State<TripListPage> {
  TripList? _tripList;

  @override
  void initState() {
    super.initState();
    StorageManager.getTripList().then((tripList) {
      setState(() {
        _tripList = TripList(tripList);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WorkSafeBC Mileage Tracker'),
      ),
      body: (_tripList != null)
          ? TripListWidget(_tripList!)
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _tripList!
                .addNewTrip(Trip(DateTime.now(), 0, 1, '6735 Station Hill Court', '8888 University Dr, Burnaby, BC V5A 1S6', TripReason.buisness));
            setState(() {
              _tripList = _tripList;
            });
          },
          child: const Icon(Icons.add)),
    );
  }
}
