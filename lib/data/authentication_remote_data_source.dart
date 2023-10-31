import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRemoteDs {
  ///sign up a user with email and password
  ///
  ///throw a[FirebaseAuthException] if the process fails
  Future<void> signUp(String email, String password);

  ///sign in a user with email and password
  ///
  ///throw a[FirebaseAuthException] if the process fails
  Future<void> signIn(String email, String password);

  ///sign out if user signed in
  Future<void> signOut();

  ///check if the user is signUp or signIn
  bool isSignedIn();
}

class AuthenticationRemoteDsImp extends AuthenticationRemoteDs {
  @override
  bool isSignedIn() => FirebaseAuth.instance.currentUser != null;

  @override
  Future<void> signIn(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signUp(String email, String password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
