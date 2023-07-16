import 'package:amazon_clone_nodejs/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    password: '',
    email: '',
    type: '',
    address: '',
    token: '',
  );
  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
