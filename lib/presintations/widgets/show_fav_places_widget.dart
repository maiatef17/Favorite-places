import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:favourite_places/data/models/place.dart';
import 'package:favourite_places/presintations/bloc/place_bloc.dart';
import 'package:favourite_places/presintations/pages/fav_page_info.dart';
import 'package:favourite_places/presintations/pages/place_location.dart';
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
                backgroundImage: NetworkImage(widget.place.image!),
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
                    widget.place.address,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      TextEditingController nameC = TextEditingController();
                      TextEditingController addressC = TextEditingController();
                      return AlertDialog(
                        title: Text(tr('Update Place')),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: nameC,
                              decoration: InputDecoration(
                                labelText: tr('name'),
                              ),
                            ),
                            TextField(
                              controller: addressC,
                              decoration: InputDecoration(
                                labelText: tr('address'),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
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
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        tr("Select Address"),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        ),
                        actions: [
                          TextButton(
                            child: Text(tr('Cancel')),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text(tr('Update')),
                            onPressed: () {
                              context.read<PlaceBloc>().add(UpdatePlace(
                                      place: Place(
                                    id: widget.place.id,
                                    name: nameC.text,
                                    address: addressC.text,
                                    image: widget.place.image,
                                    discription: '',
                                    userId: '',
                                    latitude: 1,
                                    longitude: 2,
                                  )));
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(tr('Delete Place')),
                        content: Text(
                            tr('Are you sure you want to delete this place?')),
                        actions: [
                          TextButton(
                            child: Text(tr('Cancel')),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text(tr('Delete')),
                            onPressed: () {
                              context
                                  .read<PlaceBloc>()
                                  .add(RemovePlace(id: widget.place.id));
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}
