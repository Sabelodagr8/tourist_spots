
import 'package:flutter/material.dart';

class TouristPlace with ChangeNotifier{
  final String id;
  final String name;
  final String description;
  final String url;

  TouristPlace({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
  });

  TouristPlace.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        name = json['name'],
        description = json['description'],
        url = json['url'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'description': description,
        'url': url,
      };



}
