import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:meta/meta.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '/providers/tourist_place.dart';

class TouristPlaces with ChangeNotifier {
  final List<TouristPlace> _places = [];


  // // TouristPlaces(this.places);
  TouristPlace findById(String id) {
    return _places.firstWhere((place) => place.id == id);
  }
  //
  // List<TouristPlace> get places {
  //   return [..._places];
  // }

  Future<List<TouristPlace>> fetchAndSetPlaces() async {
    var url = Uri.parse('http://192.168.8.105:8000/api/index');
    // Use GET request to fetch data from the Firebase server.
    try {
      final response = await http.get(url);
      print(json.decode(response.body));
      final parsedJson = json.decode(response.body);

      List<dynamic> values = List.filled(5, 1);

      values = json.decode(response.body);

      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            _places.add(TouristPlace.fromJson(map));
            debugPrint('Id-------${map['url']}');
          }
        }
      }

      notifyListeners();
      return _places;


    } catch (error) {
      rethrow;
    }
// Gets data from server, no need to append data
  }
}
