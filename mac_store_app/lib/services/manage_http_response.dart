import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void manageHttpResponse({
  required http.Response response, //http  response from the request//-
  required BuildContext context, //build context//-
  required VoidCallback
  onSuccess, //if user was successful signed up then we can navigate the user ro login screen
}) {
  //switch statement to handle diffrent status codes
  switch (response.statusCode) {
    case 200:
      onSuccess(); // status 200 indicate successful  request
      break;
    case 400: // status 400 indicate bad  request
      showSnackBar(context, json.decode(response.body)['msg']);
      break;
    case 500: //status 500 indicate server error
      showSnackBar(context, json.decode(response.body)['error']);
      break;
    case 201: // status 201 indicates a ressource was created successfully
      onSuccess();
      break;
  }
}

void showSnackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
}
