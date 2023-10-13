import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_eraasoft/features/home/abstract.dart';
import 'package:ecommerce_eraasoft/features/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/constants.dart';
import 'package:http/http.dart' as http;

import 'login_state.dart';


class LoginCubit extends Cubit<LoginStates> {

  LoginCubit() : super(InitialLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  // Login
  var loginUsernameController = TextEditingController();
  var loginPasswordController = TextEditingController();
  var loginFormKey = GlobalKey<FormState>();

  Future<void> loginUser(BuildContext context) async {
    String username = loginUsernameController.text;
    String password = loginPasswordController.text;
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        body: json.encode({
          'username': username,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 202 || response.statusCode == 200) {
        print('Success logged in ');
        print('${response.body} ');
        final jsonResponse = json.decode(response.body);
        authToken = jsonResponse['token'];
        print('Token: $authToken');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AbstractScreen()),
        );
        loginUsernameController.clear();
        loginPasswordController.clear();
      }
      else if (response.statusCode == 403 || response.statusCode == 401 || response.statusCode == 400) {
        final jsonResponse = json.decode(response.body);
        print(response.body);
        final message = jsonResponse['message'];
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
                ),
              ),
            ],
          ),
        );
        print(response.statusCode);
      }
      else if (response.statusCode == 422 ){
        final jsonResponse = json.decode(response.body);
        print(response.body);
        final message = jsonResponse['message'];
        Map<String, dynamic> errors = jsonResponse['errors'];
        List<String> errorMessages = [];
        errors.forEach((key, value) {
          List<String> messages = List<String>.from(value);
          errorMessages.addAll(messages);
        });
        print(errorMessages);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(errorMessages[0].toString()),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
                ),
              ),
            ],
          ),
        );
      }
      else {

        print(response.statusCode);
        print(response.body);
      }
    } catch (error) {

      print(error);
    }
  }

  bool keepLogedInChecked = false;

  // This function is called when the checkbox is checked or unchecked.
  void handleCheckboxChanged(bool value) {
    keepLogedInChecked = value;
  }

}
