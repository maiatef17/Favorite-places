import 'dart:convert';

import 'package:favourite_places/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDS {
  Future<User> getUser();
  Future<void> setUser(User u);
  Future<bool> hasSignedUp();
  Future<void> logOut();
}

class UserLocalDSImpl implements UserLocalDS {
  @override
  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String signedUpUser = prefs.getString("signedUpUser") ?? 'not found';
    final Map userDecode = jsonDecode(signedUpUser);
    final User user = User.fromMap(userDecode);

    return user;
  }

  @override
  Future<bool> hasSignedUp() async {
    final prefs = await SharedPreferences.getInstance();
    final String userDecode = prefs.getString("signedUpUser") ?? "";
    if (userDecode.isEmpty)
      return false;
    else
      return true;
  }

  @override
  Future<void> setUser(User u) async {
    final prefs = await SharedPreferences.getInstance();
    final String user = jsonEncode(u.toMap());
    await prefs.setString("signedUpUser", user);
  }

  @override
  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('signedUpUser');
  }
}
