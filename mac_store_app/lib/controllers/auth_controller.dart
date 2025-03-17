import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mac_store_app/global_variable.dart';
import 'package:mac_store_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:mac_store_app/services/manage_http_response.dart';
import 'package:mac_store_app/views/screens/authentification_screen/login.screen.dart';
import 'package:mac_store_app/views/screens/main_screen.dart';

class AuthController {
  Future<void> signUpUsers({
    required context,
    required String email,
    required String password,
    required String fullname,
  }) async {
    try {
      //initailize the user model
      User user = User(
        id: '',
        fullname: fullname,
        email: email,
        password: password,
        state: '',
        city: '',
        locality: '',
        token: '',
      );
      //make a POST request to the server for signup
      http.Response response = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(), //convert user oject to json for the request body
        headers: <String, String>{
          'Content-Type':
              'application/json ; charset=utf-8', //specify the context type as json
        }, //set the headers for the request
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );

          showSnackBar(context, 'Account has been Created for you ');
        },
      );
    } catch (e) {
      log("Error:$e");
    }
  }

  //signin users function

  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      // Make a POST request to the server for sign-in
      http.Response response = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (route) => false,
          );
          final responseData = jsonDecode(response.body);
          String token = responseData['token'];
          showSnackBar(context, 'Login Successful');
          // Store the token or handle authentication state
        },
      );
    } catch (e) {
      log("Error:$e");
    }
  }
}
