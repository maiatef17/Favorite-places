import 'dart:io';

import 'package:favourite_places/data/models/place.dart';
import 'package:flutter/material.dart';

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
          Image.asset(
            'assets/images/2.png',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
