import 'package:mileage_tracker/DataTypes/trip.dart';
import 'package:mileage_tracker/storage_manager.dart';

class TripList {

  final List<Trip> _tripList;

  TripList(this._tripList);

  void saveTripList() {
    StorageManager.saveTripList(_tripList);
  }

  int getNumTrips() {
    return _tripList.length;
  }

  Trip getTripAtIndex(int index) {
    assert(index >= 0 && index < _tripList.length);
    int inverseIndex = _tripList.length - 1 - index;
    return _tripList.elementAt(inverseIndex);
  }

  void addNewTrip(Trip newTrip) {
    _tripList.add(newTrip);
    saveTripList();
  }
}