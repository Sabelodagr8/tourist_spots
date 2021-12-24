import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourist_spots/providers/tourist_places.dart';
import 'package:tourist_spots/widgets/places_grid.dart';

class PlacesOverviewScreen extends StatefulWidget {
  const PlacesOverviewScreen({Key? key}) : super(key: key);

  @override
  State<PlacesOverviewScreen> createState() => _PlacesOverviewScreenState();
}

class _PlacesOverviewScreenState extends State<PlacesOverviewScreen> {
  // Helper variable to only execute the fetch data for the first time and then set to false to make sure that it never executes again
  var _isInit = true;
  var _isLoading = false;

  @override
  initState() {
    // Runs when the product screen overview page runs for the first time.
    // Fetch and store the data from the firebase server
    // Provider.of<Products>(context).fetchAndSetProducts(); // Won't work becuase we can't use .of(context) inside the initState
    // Another hack is to use the following approach
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // The best approach to fetch data

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<TouristPlaces>(context).fetchAndSetPlaces().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mzansi Tourist Attractions'),
      ),
      body:
      // _isLoading
      //     ? const Center(
      //         child: CircularProgressIndicator(),
      //       ):
           PlacesGrid(),
    );
  }
}
