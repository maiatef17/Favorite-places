import 'dart:io';
import 'package:favourite_places/data/models/place.dart';
import 'package:favourite_places/presintations/pages/fav_page_info.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ShowFavPlaces extends StatefulWidget {
  const ShowFavPlaces({super.key, required this.place});
  final Place place;
  @override
  State<ShowFavPlaces> createState() => _ShowFavPlacesState();
}

class _ShowFavPlacesState extends State<ShowFavPlaces> {
  File? file;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FavPageInfo(
                    place: widget.place,
                  )),
        );
        setState(() {});
      },
      child: Container(
        color: Colors.grey[900],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                file = await getImage(ImageSource.camera);
                setState(() {});
              },
              child: CircleAvatar(
                radius: 30,
                backgroundImage: file != null ? FileImage(file!) : null,
              ),
            ),
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
                  '6pxv+santo domingo,Albay,',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<File?> getImage(ImageSource source) async {
  XFile? xFile = await ImagePicker().pickImage(source: source);
  if (xFile != null) {
    return File(xFile.path);
  }

  return null;
}
