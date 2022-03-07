import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import '../services/geolocator_services.dart';
import '../services/places_service.dart';
import '../model/place_search.dart';

class ApplicationBloc with ChangeNotifier {
  late Position currentLocation;
  List<PlaceSearch> searchResults = [];

  final GeolocatorService geolocatorService = GeolocatorService();
  final PlacesService placesService = PlacesService();

  ApplicationBloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geolocatorService.getCurrentLocation();
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }
}
