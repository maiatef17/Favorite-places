import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favourite_places/data/models/place.dart';
import 'package:favourite_places/presintations/pages/add_place_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class PlaceRemoteDs {
  Future<void> addPlace(Place place);
  Future<List<Place>> getPlace();
  Future<void> removePlace(String id);
  Future<void> updatePlace(Place place);
}

class PlaceRemoteDsImp extends PlaceRemoteDs {
  @override
  Future<void> addPlace(Place place) async {
    await FirebaseFirestore.instance.collection("places").add(place.toMap());
  }

  @override
  Future<List<Place>> getPlace() async {
    final snapshot =
        await FirebaseFirestore.instance.collection("places").get();
    return snapshot.docs.map((d) => Place.fromDoc(d)).toList();
  }

  @override
  Future<void> removePlace(String id) async {
    await FirebaseFirestore.instance.collection("places").doc(id).delete();
  }

  @override
  Future<void> updatePlace(Place place) async {
    await FirebaseFirestore.instance
        .collection("places")
        .doc(place.id)
        .update(place.toMap());
  }
}
