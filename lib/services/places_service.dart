import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../model/place_search.dart';

class PlacesService {
  final key = 'AIzaSyC9B0JGTo6ZZL3sCz1BTmOMXMKcxSnmgA0';

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    var baseUrl = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=%28cities%29&key=$key');
    var response = await http.get(baseUrl);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }
}

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;
// import '../model/place_search.dart';

// class PlacesService with ChangeNotifier {
//   final key = 'AIzaSyC9B0JGTo6ZZL3sCz1BTmOMXMKcxSnmgA0';
//   // Map<String, dynamic> _places = {};
//   List<dynamic> _places = [];

//   // Map<String, dynamic> get places {
//   //   return {..._places};
//   // }

//   List<dynamic> get places {
//     return [..._places];
//   }

//   Future<void> getAutocomplete(String search) async {
//     var baseUrl = Uri.parse(
//         'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=%28cities%29&key=$key');
//     var response = await http.get(baseUrl);
//     PlaceSearch placeSearch = placeSearchFromJson(response.body);
//     _places = placeSearch.toJson() as List;
//     print(_places);
//   }
// }
