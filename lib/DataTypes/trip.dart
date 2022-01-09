import 'package:flutter/foundation.dart';
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

  Map<String, dynamic> toJson() {
    return {
      'date': _date.toString(),
      'startKm': _startKm,
      'endKm': _endKm,
      'reason': _reason.toString(),
    };
  }

  Trip.fromJson(Map<String, dynamic> json)
    : _date = DateTime.parse(json['date']),
    _startKm = json['startKm'],
    _endKm = json['endKm'],
    _reason = TripReason.values.firstWhere((e) => e.toString() == json['reason']);
}
