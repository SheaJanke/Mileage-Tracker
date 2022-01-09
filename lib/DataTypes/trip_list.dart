import 'package:mileage_tracker/DataTypes/trip.dart';
import 'package:mileage_tracker/storage_manager.dart';

class TripList {

  late List<Trip> _tripList;
  bool isLoading = false;

  TripList() {
    loadTripList();
  }

  void loadTripList() {
    isLoading = true;
    StorageManager.getTripList().then((tripList) {
      _tripList = tripList;
      isLoading = false;
      print("TripList: $_tripList");
    });
  }

  void saveTripList() {
    StorageManager.saveTripList(_tripList);
  }

  int getNumTrips() {
    if(isLoading){
      return 0;
    }
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