import 'dart:convert';

import 'package:favourite_places/data/models/place.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PlaceLocalDS {
  Future<List<Place>> getPlace();
  Future<void> addPlace(Place place);
  Future<void> clearAllPlaces();
}

const String placesKey = 'placesList';

class PlaceLocalDSImpl implements PlaceLocalDS {
  @override
  Future<List<Place>> getPlace() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> placesJson = prefs.getStringList(placesKey) ?? [];
    List<Place> places = [];
    for (int i = 0; i < placesJson.length; i++) {
      final placeJson = placesJson[i];
      final Map petMap = jsonDecode(placeJson);
      Place place = Place.fromMap(petMap);
      places.add(place);
    }

    return places;
  }

  @override
  Future<void> addPlace(Place place) async {
    final prefs = await SharedPreferences.getInstance();
    Map petMap = place.toMap();
    final String petJson = jsonEncode(petMap);
    List<String> petsJson = prefs.getStringList(placesKey) ?? [];
    petsJson.add(petJson);
    await prefs.setStringList(placesKey, petsJson);
  }

  @override
  Future<void> clearAllPlaces() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(placesKey);
  }
}
