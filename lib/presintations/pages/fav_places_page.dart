import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:favourite_places/data/data%20source/place_local_data_source/place_local_data_source.dart';
import 'package:favourite_places/data/data%20source/user_local_data_source/user_local_data_source.dart';
import 'package:favourite_places/data/models/place.dart';
import 'package:favourite_places/presintations/pages/add_place_page.dart';
import 'package:favourite_places/presintations/pages/fav_page_info.dart';
import 'package:favourite_places/presintations/pages/sign_in_page%20copy.dart';
import 'package:favourite_places/presintations/widgets/show_fav_places_widget.dart';
import 'package:flutter/material.dart';

class FavouritePlacesPage extends StatefulWidget {
  const FavouritePlacesPage({
    super.key,
  });

  @override
  State<FavouritePlacesPage> createState() => _FavouritePlacesPageState();
}

class _FavouritePlacesPageState extends State<FavouritePlacesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Container(
              color: Colors.grey[900],
              child: ListView(children: [
                SizedBox(
                  height: 100,
                ),
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
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    PlaceLocalDSImpl().clearAllPlaces();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FavouritePlacesPage()));
                  },
                  child: Text(
                    tr('Clear All Places'),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    UserLocalDSImpl().logOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignInPage()));
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: PlaceLocalDSImpl().getPlace(),
            builder: (context, snapshot) {
              print(snapshot.data);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              return ListView.builder(
                itemBuilder: (context, i) => Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: ShowFavPlaces(
                    place: snapshot.data![i],
                  ),
                ),
                itemCount: snapshot.data!.length,
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPlace()));
          setState(() {});
        },
        tooltip: 'Increment',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
