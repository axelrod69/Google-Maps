import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../blocs/application_bloc.dart';
import '../../services/places_service.dart';

class HomeScreen extends StatefulWidget {
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _mapController = Completer();

  Future<void> _goToPlaces(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(35.0, 75.0)
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ApplicationBloc>(context).currentLocation;
    // TODO: implement build
    return Scaffold(
      body: ListView(
        children: [
          TextField(
            onChanged: (value) =>
                Provider.of<ApplicationBloc>(context, listen: false)
                    .searchPlaces(value),
            decoration: const InputDecoration(
                hintText: 'Enter New Location', suffixIcon: Icon(Icons.search)),
          ),
          provider == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    Container(
                      height: 300,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        myLocationEnabled: true,
                        initialCameraPosition: CameraPosition(
                            target:
                                LatLng(provider.latitude, provider.longitude),
                            zoom: 16),
                      ),
                    ),
                    if (Provider.of<ApplicationBloc>(context).searchResults !=
                            null &&
                        Provider.of<ApplicationBloc>(context)
                                .searchResults
                                .length !=
                            0)
                      Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            backgroundBlendMode: BlendMode.darken),
                      ),
                    Container(
                      height: 300,
                      child: ListView.builder(
                        itemBuilder: (context, index) => ListTile(
                          title: Text(
                            Provider.of<ApplicationBloc>(context)
                                .searchResults[index]
                                .description,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        itemCount: Provider.of<ApplicationBloc>(context)
                            .searchResults
                            .length,
                      ),
                    )
                  ],
                )
        ],
      ),
    );
  }
}
