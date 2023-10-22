import 'package:favourite_places/data/data%20source/user_local_data_source/user_local_data_source.dart';
import 'package:favourite_places/data/models/user.dart';
import 'package:favourite_places/presintations/pages/fav_places_page.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Sign Ip Page',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<bool>(
            future: UserLocalDSImpl().hasSignedUp().then((value) {
              if (value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FavouritePlacesPage()));
              }
              return value;
            }),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return Form(
                  key: key,
                  child: Column(
                    children: [
                      TextFormField(
                          controller: Email,
                          validator: (text) {
                            if (text == null ||
                                !text.contains('@') ||
                                text.startsWith('@') ||
                                !text.endsWith('.com') ||
                                text.length < 5) {
                              return 'invalid Email';
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          )),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                          controller: Password,
                          validator: (pass) {
                            if (pass == null || pass.length < 6) {
                              return 'invalid Password';
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          )),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (key.currentState!.validate()) {
                            await UserLocalDSImpl().setUser(User(
                              name: Email.text,
                              email: Email.text,
                              password: Password.text,
                            ));
                            UserLocalDSImpl().hasSignedUp();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FavouritePlacesPage(),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        child: const Text(
                          'Sign Ip',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ));
            }),
      ),
    );
  }
}
