import 'package:mileage_tracker/DataTypes/trip.dart';
import 'package:mileage_tracker/Utils/storage_manager.dart';

class TripList {

  final List<Trip> _tripList;

  TripList(this._tripList);

  void saveTripList() {
    StorageManager.saveTripList(_tripList);
  }

  int getNumTrips() {
    return _tripList.length;
  }

  int _getInverseIndex(int index) {
    return _tripList.length - 1 - index;
  }

  Trip getTripAtIndex(int index) {
    assert(index >= 0 && index < _tripList.length);
    return _tripList.elementAt(_getInverseIndex(index));
  }

  void setTripAtIndex(Trip trip, int index) {
    if(index == -1){
      addNewTrip(trip);
    }else{
      _tripList[_getInverseIndex(index)] = trip;
    }
  }

  void addNewTrip(Trip newTrip) {
    _tripList.add(newTrip);
    saveTripList();
  }

  List<Trip> getTripList() {
    return _tripList;
  }
}