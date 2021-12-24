import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourist_spots/providers/tourist_place.dart';
import 'package:tourist_spots/providers/tourist_places.dart';
import 'package:tourist_spots/screens/place_details_screen.dart';
import 'package:tourist_spots/widgets/places_item.dart';
import 'package:http/http.dart' as http;

class PlacesGrid extends StatelessWidget {
  final List<TouristPlace> _places = [];

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

      return _places;
    } catch (error) {
      rethrow;
    }
// Gets data from server, no need to append data
  }

  @override
  Widget build(BuildContext context) {
    // Establish connection between this widget and the Provider class in the ChangeNotifierProvider object in the main.dart file
    // final placesData = Provider.of<TouristPlaces>(context);
    // final places = placesData.places;
    //
    //   // TODO: implement build
    //   return GridView.builder(
    //     padding: const EdgeInsets.all(10.0),
    //     itemCount: places.length,
    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,
    //       childAspectRatio: 0.72,
    //       crossAxisSpacing: 10,
    //       mainAxisSpacing: 10,
    //     ),
    //     itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
    //       // The ChangeNotifierProvider.value is the more efficient approach as compared to the ChangeNotifierProvider approach as we are recycling the ProductItem() widget and only managing the data
    //       value: places[index],
    //       // create: (c) => products[index],
    //       child: PlacesItem(),
    //     ),
    //   );

    return FutureBuilder<List<TouristPlace>>(
      future: fetchAndSetPlaces(),
      builder: (context, snapshot) {
        print("snapshot");
        print(snapshot.data);
        if (snapshot.hasData) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int i) {
                    return Card(
                      elevation: 4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GridTile(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlaceDetailsScreen(
                                    id: snapshot.data![i].id,
                                    name: snapshot.data![i].name,
                                    description: snapshot.data![i].description,
                                    url: snapshot.data![i].url,
                                  ),
                                ),
                              );
                              // Navigator.of(context).pushNamed(
                              //   PlaceDetailsScreen.routeName,
                              //   arguments: {
                              //     snapshot.data![i].id,
                              //     snapshot.data![i].name,
                              //     snapshot.data![i].description,
                              //     snapshot.data![i].url,
                              //   },
                              // );
                            },
                            child: Column(
                              children: <Widget>[
                                FadeInImage.assetNetwork(
                                  placeholder:
                                      'assets/images/placeholder-image.png',
                                  image: snapshot.data![i].url,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 145,
                                  // child: Image.network(
                                  //   product.imageUrl,
                                  //   fit: BoxFit.cover,
                                  //   width: double.infinity,
                                  //   height: 145,
                                  // ),
                                ),
                                Container(
                                  //padding: const EdgeInsets.only(left: 10, right: ,),
                                  // height: 50,
                                  child: Text(
                                    snapshot.data![i].name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
