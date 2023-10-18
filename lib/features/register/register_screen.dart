import 'package:ecommerce_eraasoft/features/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import '../../constants/constants.dart';
import '../../services/screen_size.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_states.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return BlocBuilder<RegisterCubit, RegisterStates>(builder: (context, state) {
      RegisterCubit cubit = RegisterCubit.get(context);
      return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: cubit.registerFormKey,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 20.0, right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: ScreenSize.screenWidth*0.4,
                        child: Image(image:AssetImage('assets/images/logo.png'))),
                    Text(
                      'Register now!',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: ScreenSize.screenHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account ? ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: (){
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),);
                          },
                          child: Text(
                            'Login!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: defaultColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenSize.screenHeight * 0.02,
                    ),
                    TextFieldComponent(
                      label: 'Name',
                      controller: cubit.registerNameController,
                      picon: Icon(Icons.person),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please enter your name';
                        }
                        if (value.length < 3) {
                          return 'name must be at least 3 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: ScreenSize.screenHeight * 0.02,
                    ),
                    TextFieldComponent(
                      label: 'Email',
                      controller: cubit.registerEmailController,
                      picon: Icon(Icons.email_outlined),
                      keyType: TextInputType.emailAddress,
                      validator: (value) {
                        bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]")
                            .hasMatch(value);
                        if (value.isEmpty) {
                          return 'please enter your email';
                        } else if (!emailValid) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: ScreenSize.screenHeight * 0.02,
                    ),
                    TextFieldComponent(
                      label: 'Password',
                      controller: cubit.registerPasswordController,
                      isPassword: true,
                      picon: Icon(Icons.lock_outline_rounded),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please enter your password';
                        }
                        if (value.length < 8) {
                          return 'password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: ScreenSize.screenHeight * 0.02,
                    ),
                    TextFieldComponent(
                      label: 'Confirm Password',
                      controller: cubit.registerConfirmPasswordController,
                      isPassword: true,
                      picon: Icon(Icons.lock_outline_rounded),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please enter your confirmed password';
                        }
                        if (value != cubit.registerPasswordController.text) {
                          return 'Passwords do not match.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: ScreenSize.screenHeight * 0.03,
                    ),
                    defaultButton(
                        text: 'Register',
                        onpressed: () {
                          if (cubit.registerFormKey.currentState!.validate()) {
                            print('Validated');
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Successful register'),
                                actions: [
                                  TextButton(
                                    child: Text(
                                      'Login',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> LoginScreen())),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
