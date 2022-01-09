import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'DataTypes/trip.dart';

enum StorageKeys {
  tripList,
}

class StorageManager {

  static const String fileName = 'data.txt';

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  static Future<Map<String, dynamic>> readJSON() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return jsonDecode(contents);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return <String, dynamic>{};
    }
  }

  static Future<File> writeJSON(Map<String, dynamic> json) async {
    final file = await _localFile;

    String encodedJSON = jsonEncode(json);

    // Write the file
    return file.writeAsString(encodedJSON);
  }

  static Future<List<Trip>> getTripList() async {
    return readJSON().then((json) {
      if(json.containsKey(StorageKeys.tripList.toString())){
        List<dynamic> list = json[StorageKeys.tripList.toString()];
        return list.map((e) => Trip.fromJson(e)).toList();
      }
      return List<Trip>.empty(growable: true);
    });
  }

  static void saveTripList(List<Trip> tripList) async {
    readJSON().then((json){
      json[StorageKeys.tripList.toString()] = tripList;
      writeJSON(json);
    });
  }

}