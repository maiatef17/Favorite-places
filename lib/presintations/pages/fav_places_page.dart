import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:favourite_places/data/models/place.dart';
import 'package:favourite_places/presintations/bloc/authentication_bloc.dart';
import 'package:favourite_places/presintations/bloc/place_bloc.dart';
import 'package:favourite_places/presintations/pages/add_place_page.dart';
import 'package:favourite_places/presintations/pages/fav_page_info.dart';

import 'package:favourite_places/presintations/pages/sign_up_page.dart';
import 'package:favourite_places/presintations/widgets/show_fav_places_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritePlacesPage extends StatefulWidget {
  const FavouritePlacesPage({
    super.key,
  });

  @override
  State<FavouritePlacesPage> createState() => _FavouritePlacesPageState();
}

class _FavouritePlacesPageState extends State<FavouritePlacesPage> {
  @override
  void initState() {
    super.initState();
    context.read<PlaceBloc>().add(GetPlace());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.grey[900],
              child: ListView(children: [
                SizedBox(height: 64),
                Text(
                  tr('Languages'),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () async {
                      context.setLocale(Locale("ar"));
                      setState(() {});
                    },
                    child: Text(
                      tr('Arabic'),
                      style: TextStyle(color: Colors.white),
                    )),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () async {
                      context.setLocale(Locale("en"));
                      setState(() {});
                    },
                    child: Text(
                      tr('English'),
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(
                  height: 540,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthenticationBloc>().add(SignOutEvent());
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()));
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: Text(
                    tr('Log Out'),
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ]))),
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: Text(
          tr('Favourite Places'),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocBuilder<PlaceBloc, PlaceState>(
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  if (state is PlaceLoadingState) CircularProgressIndicator(),
                  if (state is PlaceErrorState) Text('Error'),
                  if (state is PlaceLoaded)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: state.places.length,
                          itemBuilder: (context, i) =>
                              ShowFavPlaces(place: state.places[i])),
                    )
                ],
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPlacePage(file: null,)));
          setState(() {});
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
