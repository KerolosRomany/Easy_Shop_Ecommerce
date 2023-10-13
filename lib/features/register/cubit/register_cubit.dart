import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_eraasoft/features/home/abstract.dart';
import 'package:ecommerce_eraasoft/features/home/home_screen.dart';
import 'package:ecommerce_eraasoft/features/register/cubit/register_states.dart';
import 'package:ecommerce_eraasoft/features/register/otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/constants.dart';
import 'package:http/http.dart' as http;




class RegisterCubit extends Cubit<RegisterStates> {

  RegisterCubit() : super(InitialRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  // Register
  var registerNameController = TextEditingController();
  var registerEmailController = TextEditingController();
  var registerPasswordController = TextEditingController();
  var registerConfirmPasswordController = TextEditingController();
  var registerFormKey = GlobalKey<FormState>();

  Future<void> registerUser(BuildContext context) async {
    final url = Uri.parse('$baseUrl/register');
    final Map<String, dynamic> data ={
      'name': registerNameController.text,
      'email': registerEmailController.text,
      'password': registerPasswordController.text,
      'password_confirmation': registerConfirmPasswordController.text,
    };
    try {
      final response = await http.post(url, body: jsonEncode(data),
          headers:
          {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Success signup');
        final jsonResponse = json.decode(response.body);
        authToken = jsonResponse['data']['token'];
        print(authToken);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AbstractScreen()),
        );
        registerNameController.clear();
        registerEmailController.clear();
        registerPasswordController.clear();
        registerConfirmPasswordController.clear();
      }
      else if (response.statusCode == 403 || response.statusCode == 401) {
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
      else if (response.statusCode == 422){
        final jsonResponse = json.decode(response.body);
        print(response.body);
        final message = jsonResponse['errors'];
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
      }
    } catch (error) {
      // Error occurred during the HTTP request
      print('Error: $error');
    }
  }


  // This function is called when the radio is checked or unchecked.
  int groupValue = 0;
  int gender = 0;
  void handleRadioListChanged(value) {
    groupValue = value;
    gender= groupValue-1;
    print(groupValue);
    emit(ChangRadioState());
  }
  bool showError = false;
  void handleTextFieldErrorChanged(value) {
    showError = false;
    emit(ChangTextFieldErrorState());
  }
  void getError() {
    showError = true;
    emit(ChangTextFieldErrorState());
  }
  final TextEditingController _otpController = TextEditingController();
  Future<void> verifyOTP(BuildContext context) async {
    final otp = int.parse(_otpController.text);

    // Prepare the request body as JSON
    final requestBody = json.encode({'verify_code': otp});

    // Make the HTTP POST request to the server with the JSON body
    final response = await http.post(
      Uri.parse('$baseUrl/verify-email'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken'
      },
      body: requestBody,
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 202) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid OTP'),
            content: Text('Please enter the correct OTP.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

}
