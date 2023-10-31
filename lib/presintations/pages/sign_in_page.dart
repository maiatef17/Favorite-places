import 'package:favourite_places/data/authentication_remote_data_source.dart';
import 'package:favourite_places/presintations/bloc/authentication_bloc.dart';
import 'package:favourite_places/presintations/pages/fav_places_page.dart';
import 'package:favourite_places/presintations/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController EmailC = TextEditingController();
  TextEditingController PasswordC = TextEditingController();
  @override
  void initState() {
    context.read<AuthenticationBloc>().add(IsSignedInEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: const Text(
          'Sign In Page',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
          if (state is Authentication) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => FavouritePlacesPage()));
          }
        }, builder: (context, state) {
          print(state);
          return Center(
              child: Form(
            key: key,
            child: ListView(
              children: [
                if (state is AuthenticationLodingState)
                  CircularProgressIndicator(),
                if (state is AuthenticationErrorState) Text('Error'),
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  'assets/images/sign in.png',
                  scale: 2,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      TextFormField(
                          controller: EmailC,
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
                          controller: PasswordC,
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (key.currentState!.validate()) {
                          context.read<AuthenticationBloc>().add(SignInEvent(
                                email: EmailC.text,
                                password: PasswordC.text,
                              ));
                          if (state is UnAuthentication)
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Sign Up Required'),
                                content: Text(
                                    'Please sign up first before logging in.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                )
              ],
            ),
          ));
        }),
      ),
    );
  }
}
