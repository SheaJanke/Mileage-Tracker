import 'package:flutter/foundation.dart';
import 'package:mileage_tracker/DataTypes/trip_reasons.dart';

class Trip {
  DateTime date;
  int startKm, endKm;
  String startAddress, endAddress, notes;
  TripReason reason;

  Trip(this.date, this.startKm, this.endKm, this.startAddress, this.endAddress, this.reason, this.notes);

  int calcTripDistance() {
    return endKm - startKm;
  }

  bool isValid() {
    return startKm < endKm;
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toString(),
      'startKm': startKm,
      'endKm': endKm,
      'reason': reason.toString(),
      'startAddress': startAddress,
      'endAddress': endAddress,
      'notes': notes,
    };
  }

  Trip.fromJson(Map<String, dynamic> json)
    : date = DateTime.parse(json['date']),
    startKm = json['startKm'],
    endKm = json['endKm'],
    startAddress = json['startAddress'],
    endAddress = json['endAddress'],
    reason = TripReason.values.firstWhere((e) => e.toString() == json['reason']),
    notes = json['notes'];
}
