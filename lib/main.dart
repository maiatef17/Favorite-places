import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:favourite_places/data/authentication_remote_data_source.dart';
import 'package:favourite_places/data/image_picker_.dart';
import 'package:favourite_places/data/models/place.dart';
import 'package:favourite_places/data/places_remote_data_source.dart';
import 'package:favourite_places/presintations/bloc/authentication_bloc.dart';
import 'package:favourite_places/presintations/bloc/place_bloc.dart';
import 'package:favourite_places/presintations/pages/fav_places_page.dart';
import 'package:favourite_places/presintations/pages/sign_up_page.dart';
import 'package:favourite_places/presintations/pages/stream_example.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.instance.subscribeToTopic("topic");
  @pragma('vm: entry-point')
  Future<void> onBackgroundMessage(RemoteMessage message) async {
    print('Notification Received While App Is In The Background');
  }

  FirebaseMessaging.onMessage.listen(
      (event) => print('Notification Received While App Is In The Foreground'));
  FirebaseMessaging.onMessageOpenedApp
      .listen((event) => print('Notification Tapped'));
  FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
  final token =
      FirebaseMessaging.instance.getToken().then((value) => print(value));

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(AuthenticationRemoteDsImp()),
        ),
        BlocProvider<PlaceBloc>(
          create: (context) => PlaceBloc(PlaceRemoteDsImp()),
        ),
      ],
      child: EasyLocalization(
          fallbackLocale: Locale('ar'),
          child: const MyApp(),
          supportedLocales: [Locale('en'), Locale('ar')],
          path: 'assets/translations')));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Ubuntu Condensed',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: const SignUpPage());
  }
}
