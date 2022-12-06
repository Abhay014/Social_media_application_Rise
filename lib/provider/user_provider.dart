import 'package:flutter/cupertino.dart';
import 'package:rise_flutter/model/user.dart';
import 'package:rise_flutter/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  // final AuthMethods _authMethods = AuthMethods();
  // User? _user;
  // User? get getUser => _user;

  // Future<void> refreshUser() async {
  //   User user = await _authMethods.getUserDetails();
  //   _user = user;
  //   notifyListeners();
  // }

  User? _user;

  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;

    notifyListeners();
  }
}
