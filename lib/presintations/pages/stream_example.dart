import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StreamExample extends StatefulWidget {
  const StreamExample({super.key});

  @override
  State<StreamExample> createState() => _StreamExampleState();
}

class _StreamExampleState extends State<StreamExample> {
  final controller = StreamController();
  Future<void> addStreamDta() async {
    for (var i = 0; i < 100; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
      controller.sink.add(i);
    }
  }

  @override
  void initState() {
    addStreamDta();
    super.initState();
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: controller.stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("error");
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return Center(child: Text("stream data${snapshot.data}"));
          }),
    );
  }
}
