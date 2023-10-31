import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Place {
  String? image;
  final String name, discription, id, userId, address;
  final double latitude, longitude;

  Place(
      {required this.image,
      required this.name,
      required this.discription,
      required this.id,
      required this.userId,
      required this.address,
      required this.latitude,
      required this.longitude});

  Map<String, dynamic> toMap() {
    return {
      "image": image,
      "name": name,
      "discription": discription,
      "id": id,
      "userId": userId,
      "address": address,
      "latitude": latitude,
      "longitude": longitude,
    };
  }

  factory Place.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return Place(
        id: doc.id,
        image: doc.data()['image'],
        name: doc.data()['name']!,
        discription: doc.data()['discription'],
        userId: doc.data()['userId'],
        address: doc.data()['address'],
        latitude: doc.data()['latitude'],
        longitude: doc.data()['longitude']);
  }
}
