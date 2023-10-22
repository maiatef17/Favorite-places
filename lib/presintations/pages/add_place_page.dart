import 'dart:ffi';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:favourite_places/data/data%20source/place_local_data_source/place_local_data_source.dart';
import 'package:favourite_places/data/models/place.dart';
import 'package:favourite_places/presintations/pages/place_location.dart';
import 'package:flutter/material.dart';
import 'package:favourite_places/presintations/pages/fav_places_page.dart';
import 'package:geolocator/geolocator.dart';

class AddPlace extends StatefulWidget {
  const AddPlace({
    super.key,
  });

  @override
  State<AddPlace> createState() => _AddPlaceState();
}
 int id = Random().nextInt(1000);
class _AddPlaceState extends State<AddPlace> {
  bool Location = false;
  Position? currentPosition;
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController name = TextEditingController();
  PlaceLocalDSImpl placeDS = PlaceLocalDSImpl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          title: Text(
            tr('Add new place'),
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: key,
            child: ListView(
              children: [
                TextFormField(
                  controller: name,
                  validator: (String? text) {
                    if (text == null || text.isEmpty) {
                      return tr('field is required');
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: tr('name'),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 280,
                  child: Image.asset(
                    'assets/images/4.png',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 210,
                  child: Image.asset(
                    'assets/images/3.png',
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () async {
                          currentPosition = await getCurrentLocation();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.add_location_sharp,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(tr('Get Current Location'),
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white))
                          ],
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () async {
                          Location = await checkLocationService();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlaceLocation()));
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.map,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(tr('Select on Map'),
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white))
                          ],
                        ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        id++;
                    placeDS.addPlace(Place(id, name.text ));
                    print(id);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FavouritePlacesPage()));
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          tr('Add Place'),
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}

Future<bool> checkLocationService() => Geolocator.isLocationServiceEnabled();
Future<Position?> getCurrentLocation() async {
  await Geolocator.requestPermission();
  final status = await Geolocator.checkPermission();
  if (status == LocationPermission.always ||
      status == LocationPermission.whileInUse) {
    return Geolocator.getCurrentPosition();
  }
  return null;
}
