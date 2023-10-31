import 'package:favourite_places/data/authentication_remote_data_source.dart';
import 'package:favourite_places/presintations/bloc/authentication_bloc.dart';
import 'package:favourite_places/presintations/pages/fav_places_page.dart';
import 'package:favourite_places/presintations/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
        backgroundColor: Colors.black,
        title: const Text(
          'Sign Up Page',
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
                  'assets/images/sign up.png',
                  scale: 2,
                ),
                SizedBox(height: 20,),
               Padding(
                 padding: const EdgeInsets.all(25),
                 child: Column(children: [ TextFormField(
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
                      )),],),
               ),
                const SizedBox(
                  height: 16,
                ),
                if (state is UnAuthentication)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (key.currentState!.validate()) {
                            context.read<AuthenticationBloc>().add(SignUpEvent(
                                email: EmailC.text, password: PasswordC.text));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?  ',
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
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
