import 'package:easy_localization/easy_localization.dart';
import 'package:favourite_places/presintations/pages/fav_places_page.dart';
import 'package:favourite_places/presintations/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      fallbackLocale: Locale('ar'),
      child: const MyApp(),
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations'));
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
