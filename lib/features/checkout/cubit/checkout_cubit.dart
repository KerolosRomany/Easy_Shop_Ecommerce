import 'dart:convert';

import 'package:ecommerce_eraasoft/features/home/abstract.dart';
import 'package:ecommerce_eraasoft/features/home/cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/constants.dart';
import '../../../models/models.dart';
import 'checkout_states.dart';
import 'package:http/http.dart' as http;

class CheckoutCubit extends Cubit<CheckoutStates> {
  final double totalInCheckout;
  CheckoutCubit(this.totalInCheckout) : super(InitialCheckoutState());

  static CheckoutCubit get(context) => BlocProvider.of(context);
  var checkoutFormKey = GlobalKey<FormState>();
  String selectedItem = 'Cairo';
  void changeCity(value){
    selectedItem = value;
    emit(SuccessfulChangeCityState());
  }

  var profileFirstNameController = TextEditingController();
  var profileLastNameController = TextEditingController();
  var profileEmailController = TextEditingController();
  var profilePhoneController = TextEditingController();
  var profileAddressController = TextEditingController();

  Future<void> getProfileDetails() async {
    try {
      final url = Uri.parse('$baseUrl/users/$userId');
      final response = await http.get(
          url,
          headers:
          {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken'
          });
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        final dynamic data = decodedBody; // Accessing data as a single object
        print('profile');
        print(data);
        Person profile = Person.fromJson(data); // Create a single instance
        print('profile');
        print(profile);

        profileFirstNameController.text = profile.username;
        profileLastNameController.text = profile.lastName;
        profileEmailController.text = profile.email;
        profilePhoneController.text = profile.phone == "null" ? "" : profile.phone ;
        profileAddressController.text = (profile.address.address == "null" ? "" : profile.address.address);

        emit(CheckoutSuccessfulGetProfileDataState());
      } else {
        throw 'Failed to load profile data. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load profile data: ${e.toString()}';
    }
  }









  // String? totalInCart;

}