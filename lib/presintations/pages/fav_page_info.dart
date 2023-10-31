import 'dart:io';

import 'package:favourite_places/data/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';

class FavPageInfo extends StatefulWidget {
  const FavPageInfo({Key? key, required this.place}) : super(key: key);
  final Place place;

  @override
  State<FavPageInfo> createState() => _FavPageInfoState();
}

class _FavPageInfoState extends State<FavPageInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(widget.place.name, style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            widget.place.image!,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 80,
          ),
          Positioned(
            bottom: 80,
            left: 110,
            right: 110,
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
                      ("Address: ${widget.place.address}"),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
