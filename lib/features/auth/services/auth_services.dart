import 'dart:convert';

import 'package:amazon_clone_nodejs/constants/error_handling.dart';
import 'package:amazon_clone_nodejs/constants/global_variables.dart';
import 'package:amazon_clone_nodejs/constants/utils.dart';
import 'package:amazon_clone_nodejs/features/home/screens/home_screen.dart';
import 'package:amazon_clone_nodejs/models/user.dart';
import 'package:amazon_clone_nodejs/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/signin'),
      //   body: jsonEncode({
      //     'email': email,
      //     'password': password,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );

      // ignore: use_build_context_synchronously
      // httpErrorHandle(
      //     response: res,
      //     context: context,
      //     onSuccess: () async {
      //       Provider.of<UserProvider>(context, listen: false).setUser(res.body);
      //       SharedPreferences prefs = await SharedPreferences.getInstance();
      //       await prefs.setString(
      //           'x-auth-token', jsonDecode(res.body)['token']);
      //       Navigator.pushNamedAndRemoveUntil(
      //           context, HomeScreen.routeName, (route) => false);
      //     });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
