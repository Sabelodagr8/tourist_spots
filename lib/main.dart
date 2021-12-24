import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourist_spots/providers/tourist_place.dart';
import 'package:tourist_spots/providers/tourist_places.dart';
import 'package:tourist_spots/screens/place_details_screen.dart';
import 'package:tourist_spots/screens/places_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: TouristPlaces()),
        ChangeNotifierProvider.value(
            value: TouristPlace(
          id: '',
          name: '',
          description: '',
          url: '',
        )),
      ],
      child: MaterialApp(
        title: 'Mzansi Tourist Attractions',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
              .copyWith(secondary: Colors.amberAccent),
          primaryColor: Colors.pink,
          fontFamily: 'Lato',
        ),
        home: PlacesOverviewScreen(),
        routes: {
          PlaceDetailsScreen.routeName: (ctx) => PlaceDetailsScreen(
                id: '',
                name: '',
                description: '',
                url: '',
              )
        },
      ),
    );
  }
}
