import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourist_spots/providers/tourist_place.dart';
import 'package:tourist_spots/screens/place_details_screen.dart';

class PlacesItem extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final place = Provider.of<TouristPlace>(context, listen: false);

    return Card(
      elevation: 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                PlaceDetailsScreen.routeName,
                arguments: place.id,
              );
            },
            child: Column(
              children: <Widget>[
                Hero(
                  tag: place.id,
                  child: FadeInImage.assetNetwork(
                    placeholder: '',
                    image: place.url,
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
                ),
                Container(
                  //padding: const EdgeInsets.only(left: 10, right: ,),
                  // height: 50,
                  child: Text(
                    place.name,
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
  }

}