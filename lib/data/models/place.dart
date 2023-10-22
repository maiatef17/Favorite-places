import 'dart:io';

class Place {
  final String name;
  // final String location;
  final int id;
  //final File image;
  Place(
    this.id,
    this.name,
  );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
    };
  }

  factory Place.fromMap(Map m) {
    return Place(
      m["id"],
      m["name"],
    );
  }
}
