import 'package:ecommerce_eraasoft/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import '../../services/screen_size.dart';
import '../register/register_screen.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return BlocBuilder<LoginCubit, LoginStates>(builder: (context, state) {
      LoginCubit cubit = LoginCubit.get(context);
      return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: cubit.loginFormKey,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 20.0, right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: ScreenSize.screenWidth*0.6,
                        child: Image(image:AssetImage('assets/images/logo.png'))),
                    Text(
                      'Login now!',
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
                          'Don\'t have an account ? ',
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
                                MaterialPageRoute(builder: (context) => RegisterScreen()),);
                          },
                          child: Text(
                            'Register Now!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: defaultColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenSize.screenHeight * 0.02,
                    ),
                    TextFieldComponent(
                      label: 'Username',
                      controller: cubit.loginUsernameController,
                      picon: Icon(Icons.person),
                      keyType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: ScreenSize.screenHeight * 0.02,
                    ),
                    TextFieldComponent(
                      label: 'Password',
                      controller: cubit.loginPasswordController,
                      isPassword: true,
                      picon: Icon(Icons.lock_outline_rounded),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: ScreenSize.screenHeight * 0.03,
                    ),
                    defaultButton(
                        text: 'Login',
                        onpressed: () {
                          if (cubit.loginFormKey.currentState!.validate()) {
                            print('Validated');
                            cubit.loginUser(context);
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
