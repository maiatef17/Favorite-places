import 'dart:io';
import 'package:favourite_places/data/image_picker_.dart';
import 'package:favourite_places/data/models/place.dart';
import 'package:favourite_places/data/storage_helper.dart';
import 'package:favourite_places/presintations/bloc/place_bloc.dart';
import 'package:favourite_places/presintations/pages/fav_page_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ShowFavPlaces extends StatefulWidget {
  const ShowFavPlaces({super.key, required this.place});
  final Place place;
  @override
  State<ShowFavPlaces> createState() => _ShowFavPlacesState();
}

class _ShowFavPlacesState extends State<ShowFavPlaces> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FavPageInfo(
                  place: widget.place,
                )),
      );
      setState(() {});
    }, child: BlocBuilder<PlaceBloc, PlaceState>(
      builder: (context, state) {
        return Container(
          color: Colors.grey[900],
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(widget.place.image),
              ),
              // GestureDetector(
              //   onTap: () async {
              //     File? file =
              //         await ImagePickerHelperImpl().pickImageFromGallery();
              //     StorageHelperImp().uploadImageFromFile(file!);
              //   },
              //   child: CircleAvatar(
              //     radius: 30,
              //     // backgroundImage: file != null ? FileImage(file!) : null,
              //   ),
              // ),

              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.place.name,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Text(
                    widget.place.address,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              )
            ],
          ),
        );
      },
    ));
  }
}
