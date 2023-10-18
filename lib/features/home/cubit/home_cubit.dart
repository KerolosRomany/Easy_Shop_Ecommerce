import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_eraasoft/features/cart/cart_screen.dart';
import 'package:ecommerce_eraasoft/features/home/home_screen.dart';
import 'package:ecommerce_eraasoft/features/post/post_screen.dart';
import 'package:ecommerce_eraasoft/features/products/specific_book_screen.dart';
import 'package:ecommerce_eraasoft/features/profile/profile_screen.dart';
import 'package:ecommerce_eraasoft/features/register/cubit/register_states.dart';
import 'package:ecommerce_eraasoft/features/register/otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/constants.dart';
import 'package:http/http.dart' as http;

import '../../../models/models.dart';
import '../../products/products_screen.dart';
import '../category_products.dart';
import 'home_states.dart';




class HomeCubit extends Cubit<HomeStates> {

  HomeCubit() : super(InitialHomeState());

  static HomeCubit get(context) => BlocProvider.of(context);
  String? username;
  Person profileModel = Person(
  image: '',
  height: 1,
  phone: '',
  id: 0,
  address: Address(address: '',city: '',coordinates: Coordinates(lat: 1, lng: 1), postalCode: '',state: '',),
  email: '',
  gender: '',
   age: 90,
   bank: Bank(cardExpire: '',cardNumber: '', cardType: '',currency: '', iban: '',),
   birthDate: '',
   bloodGroup: '',
   company: Company( address: Address(address: 'address', city: 'city', coordinates: Coordinates(lat: 1, lng: 1), postalCode: 'postalCode', state: 'state'),name: '', department: '',title: '',),
   domain: '',
   ein: '',
   eyeColor: '',
   firstName: '',
   hair: Hair(color: '',type: '',),
   ip: '',
   lastName: '',
   macAddress: '',
   maidenName: '',
   password: '',
   ssn: '',
    university: '',
    userAgent: '',
    username: '',
    weight: 1234,
  );
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
        print('$userId is userId');
        print(data);
        Person profile = Person.fromJson(data); // Create a single instance
        print('profile');
        print(profile);
        username = profile.username;
        profileFirstNameController.text = profile.username;
        profileLastNameController.text = profile.lastName;
        profileEmailController.text = profile.email;
        profilePhoneController.text = profile.phone == "null" ? "" : profile.phone ;
        profileCityController.text = (profile.address.city == "null" ? "" :profile.address.city) ;
        profileAddressController.text = (profile.address.address == "null" ? "" : profile.address.address);
        print(username);
        profileModel = profile;
        emit(HomeSuccessfulGetProfileDataState());
      } else {
        throw 'Failed to load profile data. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load profile data: ${e.toString()}';
    }
  }

  List<ProductModel> productsList=[];
  List<ProductModel> categoryProductsList=[];
  Future<void> getProducts() async {
    try {
      final url = Uri.parse('$baseUrl/products');
      final response = await http.get(url,
          headers:
          {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken'
          });
      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        final List<dynamic> data = decodedBody['products'];
        final products = data
            .map<ProductModel>((json) => ProductModel.fromJson(json))
            .toList();
        productsList=products;
        emit(HomeSuccessfulGetProductsState());
      } else {
        throw 'Failed to load products. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load products: $e';
    }
  }
  List<CategoryModel> categoriesData=[];
  Future<void> getCategories() async {
    try {
      final url = Uri.parse('$baseUrl/products/categories');
      final response = await http.get(url,
          headers:
          {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken'
          });
      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        final List<dynamic> data = decodedBody;
        final categories = data
            .map<CategoryModel>((json) => CategoryModel.fromJson(json))
            .toList();
        categoriesData = categories;
        print(categoriesData);
        emit(HomeSuccessfulGetCategories());
      } else {
        throw 'Failed to load categories. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load categories: $e';
    }
  }
  List<CategoryModel> categories = [
    CategoryModel(title:  "smartphones",),
    CategoryModel(title:  "laptops",),
    CategoryModel(title:  "fragrances",),
    CategoryModel(title:  "skincare",),
    CategoryModel(title:  "groceries",),
    CategoryModel(title:  "home-decoration",),
    CategoryModel(title:  "furniture",),
    CategoryModel(title:  "tops",),
    CategoryModel(title:  "womens-dresses",),
    CategoryModel(title:  "womens-shoes",),
    CategoryModel(title:  "womens-shoes",),
    CategoryModel(title:  "mens-shirts",),
    CategoryModel(title:  "mens-shoes",),
    CategoryModel(title:  "mens-watches",),
    CategoryModel(title:  "womens-watches",),
    CategoryModel(title:  "womens-bags",),
    CategoryModel(title:  "womens-jewellery",),
    CategoryModel(title:  "sunglasses",),
    CategoryModel(title:  "automotive",),
    CategoryModel(title:  "motorcycle",),
    CategoryModel(title:  "lighting",),
  ];
  ProductModel specificBook = ProductModel(
    title: '',
    id: 1000,
    brand: '',
    category: '',
    description: '',
    discountPercentage: 102,
    images: [],
    price: 1064,
    rating: 46,
    stock: 102,
    thumbnail: '',
  );
  Future<void> getSpecificProduct(String id,BuildContext context) async {
    try {
      final url = Uri.parse('$baseUrl/products/$id');
      final response = await http.get(url,
          headers:
          {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken'
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        // final Map<String,dynamic> data = decodedBody['data'];
        final ProductModel product = ProductModel.fromJson(decodedBody);
        specificBook=product;
        Navigator.push(context, MaterialPageRoute(builder: (context)=> SpecificProductScreen(product: product)));
        emit(HomeSuccessfulGetSpecificBookState());
      } else {
        throw 'Failed to load specific book. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load specific book: $e';
    }
  }
  Future<void> getSpecificCategoryProducts(String title,BuildContext context) async {
    try {
      final url = Uri.parse('$baseUrl/products/category/$title');
      final response = await http.get(url,
          headers:
          {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken'
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        final List<dynamic> data = decodedBody['products'];
        final products = data
            .map<ProductModel>((json) => ProductModel.fromJson(json))
            .toList();
        categoryProductsList=products;
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryProductsScreen(categoryTitle: title,categoryProducts: products,)));
        emit(HomeSuccessfulGetSpecificCategoryState());
      } else {
        throw 'Failed to load specific category. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load specific category: $e';
    }
  }

  var profileFirstNameController = TextEditingController();
  var profileLastNameController = TextEditingController();
  var profileEmailController = TextEditingController();
  var profilePhoneController = TextEditingController();
  var profileCityController = TextEditingController();
  var profileAddressController = TextEditingController();
  var profileFormKey = GlobalKey<FormState>();
  final List<String> imgList = [
    'assets/images/sales1.jpg',
    'assets/images/sales2.jpg',
    'assets/images/sales3.jpg',
    'assets/images/sales4.jpg',

  ];
  int pageIndex = 0;
  void chanegePageIndex(int value){
    pageIndex = value;
    emit(HomeChangeSliderIndexState());
  }


  int currentIndex = 0;

  void onTabTapped(int index) {
      currentIndex = index;
      emit(HomeSuccessfulChangeNavigationBarState());
  }
  List<Widget> screens = [
    HomeScreen(),
    ProductsScreen(),
    FeedScreen(),
    CartScreen( productsAddedToCart: []),
    ProfileScreen(),
  ];

  Future<void> updateUserDetails(BuildContext context) async {
    final url = Uri.parse('$baseUrl/users/$userId');
    final Map<String, dynamic> data ={
      'firstName': profileFirstNameController.text,
      'lastName': profileLastNameController.text,
      'email': profileEmailController.text,
      'city': profileCityController.text,
      'phone': profilePhoneController.text,
    };
    try {
      final response = await http.put(url, body: jsonEncode(data),
          headers:
          {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          }
      );
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Success update');
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Successful update'),
            content: Text('Successful update'),
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
      else if (response.statusCode == 403 || response.statusCode == 401) {
        final jsonResponse = json.decode(response.body);
        print(response.body);

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Error in update user'),
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

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Error in update user'),
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




}
