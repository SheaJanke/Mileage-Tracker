import 'package:mileage_tracker/DataTypes/trip_reasons.dart';

class Trip {
  DateTime _date;
  int _startKm, _endKm;
  TripReason _reason;

  Trip(this._date, this._startKm, this._endKm, this._reason);

  int calcTripDistance() {
    return _endKm - _startKm;
  }

  void setDate(DateTime date) {
    _date = date;
  }

  DateTime getDate() {
    return _date;
  }

  void setStartKm(int startKm) {
    _startKm = startKm;
  }

  int getStartKm() {
    return _startKm;
  }

  void setEndKm(int endKm) {
    _endKm = endKm;
  }

  int getEndKm() {
    return _endKm;
  }

  void setReason(TripReason reason) {
    _reason = reason;
  }

  TripReason getReason() {
    return _reason;
  }

  bool isValid() {
    return _startKm < _endKm;
  }
}
