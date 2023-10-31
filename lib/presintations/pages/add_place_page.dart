import 'dart:ffi';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:favourite_places/data/models/place.dart';
import 'package:favourite_places/presintations/bloc/place_bloc.dart';
import 'package:favourite_places/presintations/pages/place_location.dart';
import 'package:flutter/material.dart';
import 'package:favourite_places/presintations/pages/fav_places_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class AddPlacePage extends StatefulWidget {
  const AddPlacePage({
    super.key,
  });

  @override
  State<AddPlacePage> createState() => _AddPlacePageState();
}

class _AddPlacePageState extends State<AddPlacePage> {
  bool Location = false;
  Position? currentPosition;
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController nameC = TextEditingController();
  TextEditingController imageC = TextEditingController();
  TextEditingController addressC = TextEditingController();
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
        body: BlocBuilder<PlaceBloc, PlaceState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: key,
                child: ListView(
                  children: [
                    if (state is PlaceInitial)
                      SizedBox(
                        height: 50,
                      ),
                    TextFormField(
                      controller: nameC,
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
                      height: 30,
                    ),
                    TextFormField(
                      controller: imageC,
                      validator: (String? text) {
                        if (text == null || text.isEmpty) {
                          return tr('field is required');
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: tr('image'),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: addressC,
                      validator: (String? text) {
                        if (text == null || text.isEmpty) {
                          return tr('field is required');
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: tr('address'),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 100,
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
                            onPressed: () async {},
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
                                MaterialStateProperty.all(Colors.black),
                          ),
                          onPressed: () async {
                            final selectedAddress = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlaceLocation()),
                            );
                            if (selectedAddress != null) {
                              setState(() {
                                addressC.text = selectedAddress;
                              });
                            }
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
                              Text(
                                tr('Select on Map'),
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ],
                          ),
                        )
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
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FavouritePlacesPage()));
                            context.read<PlaceBloc>().add(AddPlace(
                                place: Place(
                                    image: imageC.text,
                                    name: nameC.text,
                                    discription: "discription",
                                    id: "1",
                                    userId: 'userId',
                                    address: addressC.text,
                                    latitude: 1,
                                    longitude: 2)));
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
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
