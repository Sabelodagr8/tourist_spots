import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourist_spots/providers/tourist_place.dart';
import 'package:tourist_spots/providers/tourist_places.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static String routeName = '/place-details';
  final String id;
  final String name;
  final String description;
  final String url;

  PlaceDetailsScreen({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Hero(
                      tag: id,
                      child: Image.network(
                        url,
                        height: 250,
                        width: double.infinity, // takes all the available width
                        fit: BoxFit
                            .cover, // Resize and crop image so that it can fit nicely into the container
                      ),
                    ),
                  ), // Used to add rounded corners to the Image Widget
                  Positioned(
                    // Used to position widgets only inside the Stack() widget
                    bottom: 0,
                    right: 0,
                    child: Container(
                      // To prevent text overflow
                      width: 300,
                      color: Colors.black54,
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 20,
                      ),
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                        ),
                        softWrap: true, // Wraps text if it is too long
                        overflow: TextOverflow
                            .fade, // adds a style to text that overflows
                      ),
                    ),
                  ),

                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      Text(description),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
