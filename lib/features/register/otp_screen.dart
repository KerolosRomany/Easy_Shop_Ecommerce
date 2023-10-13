
import 'package:ecommerce_eraasoft/features/register/cubit/register_cubit.dart';
import 'package:ecommerce_eraasoft/features/register/cubit/register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../components/components.dart';
import '../../services/screen_size.dart';


class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return BlocConsumer<RegisterCubit,RegisterStates> (
      listener: (context,state){},
      builder: (context,state){
        RegisterCubit cubit = RegisterCubit.get(context);
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Verify your email',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: ScreenSize.screenHeight * 0.05,
                    ),
                    Text(
                      'Enter 6 digits code numbers sent to ${cubit.registerEmailController.text}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: ScreenSize.screenHeight * 0.05,
                    ),
                    TextField(
                      controller: _otpController,
                      decoration: InputDecoration(
                        labelText: 'OTP',
                      ),
                      keyboardType: TextInputType.number,
                      // Specify the keyboard type as number
                    ),
                    SizedBox(height: 20.0),
                    defaultButton(
                      text: 'Verify',
                      onpressed: (){
                        cubit.verifyOTP(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
