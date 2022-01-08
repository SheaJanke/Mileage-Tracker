import 'package:mileage_tracker/DataTypes/trip.dart';

class TripList {

  late List<Trip> _tripList;

  TripList() {
    _tripList = loadTripList();
  }

  List<Trip> loadTripList() {
    return List<Trip>.empty(growable: true);
  }

  void saveTripList() {
    
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
  }

}