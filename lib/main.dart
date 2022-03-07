import 'package:flutter/material.dart';
import './src/screens/home_screen.dart';
import './blocs/application_bloc.dart';
import 'package:provider/provider.dart';
import './blocs/application_bloc.dart';
import './services/places_service.dart';

void main() {
  runApp(PlacesAutocomplete());
}

class PlacesAutocomplete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ApplicationBloc()),
        // ChangeNotifierProvider(create: (context) => PlacesService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.red),
        home: HomeScreen(),
      ),
    );
  }
}
