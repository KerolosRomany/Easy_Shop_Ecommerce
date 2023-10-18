
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_eraasoft/features/products/specific_book_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../constants/constants.dart';
import '../../../models/models.dart';
import 'cart_states.dart';
class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(InitialCartState());
  static CartCubit get(context) => BlocProvider.of(context);
  List<CartItemModel> cartProducts=[];
  double totalInCart=0;
  Future<void> getCartProducts(List<CartItemModel> productsAddedToCart) async {
    try {
      final url = Uri.parse('$baseUrl/carts/user/$userId');
      final response = await http.get(url,
          headers:
          {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken'
          });

      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        print(decodedBody);
        final List<dynamic> data = decodedBody['carts'][0]['products'];
        double discountedTotal = decodedBody['carts'][0]['discountedTotal'].toDouble();
        discountedTotal = discountedTotal - discountedTotal;   // discountedTotal in the api is getting 3414 and When I change that and get discountedTotal again get 3414 because I can't access the api to post or put
        cartId = decodedBody['carts'][0]['id'];
        print(data);
        final products = data
            .map<CartItemModel>((json) => CartItemModel.fromJson(json))
            .toList();

        // cartProducts=products;    // by using api
        cartProducts=productsAddedToCart;
        // cartProducts.insertAll(0,productsAddedToCart);   // insert added products into cart products
        print(cartProducts);
        double productsAddedToCartDiscountedTotal=0;
        for (var product in productsAddedToCart){
          productsAddedToCartDiscountedTotal = productsAddedToCartDiscountedTotal +product.discountedPrice;
        }
        totalInCart=discountedTotal+ productsAddedToCartDiscountedTotal;
        emit(CartSuccessfulGetCartBooksState());
      } else {
        throw 'Failed to load cart products. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load cart products: $e';
    }
  }
  List<CartItemModel> getCartProductsState(){
    return cartProducts;
  }
  Future<void> addToCart(int productId,int quantity,BuildContext context) async {
    quantity=quantity+1;
    final url = Uri.parse('$baseUrl/carts/$userId');
    final Map<String, dynamic> data ={
      'products': [
        {
          'id': productId,
          'quantity': quantity,
        }
      ]
    };
    try {
      final response = await http.put(url, body: jsonEncode(data),
          headers:
          {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          }
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Success added to cart');
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        // final double discountedTotal = jsonResponse['discountedTotal'].toDouble();
        // totalInCart = discountedTotal;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Successful added'),
            content: Text('Success added to cart'),
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
        emit(CartSuccessfullBookAddedState());
      }
      else if (response.statusCode == 403 || response.statusCode == 401) {
        final jsonResponse = json.decode(response.body);
        print(response.body);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Error in adding product'),
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
            content: Text('Error in adding product'),
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
  int cartId = 0;
  Future<void> removeItemFromCart(int productId,int quantity,BuildContext context) async {
    quantity=quantity-1;
    final url = Uri.parse('$baseUrl/carts/$userId');
    final Map<String, dynamic> data ={
      'products': [
        {
          'id': productId,
          'quantity': quantity,
        }
      ]
    };
    try {
      final response = await http.put(url, body: jsonEncode(data),
          headers:
          {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          }
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Success removed');
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Successful removed'),
            content: Text('Successful removed item from cart'),
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
        emit(CartSuccessfullRemovedBookState());
      }
      else if (response.statusCode == 403 || response.statusCode == 401) {
        final jsonResponse = json.decode(response.body);
        print(response.body);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Error in removing item from cart'),
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
            content: Text('Error in removing item from cart'),
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
  Future<void> removeProductFromCart(int cartId,int productId,int quantity,BuildContext context) async {
    quantity=0;
    final url = Uri.parse('$baseUrl/carts/$cartId');
    final Map<String, dynamic> data ={
          'products': [
            {
              'id': productId,
              'quantity': quantity,
            }
          ]

    };
    try {
      final response = await http.put(url, body: jsonEncode(data),
          headers:
          {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          }
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Success removed');
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Successful removed'),
            content: Text('Successful removed product from cart'),
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
        emit(CartSuccessfullRemovedBookState());
      }
      else if (response.statusCode == 403 || response.statusCode == 401) {
        final jsonResponse = json.decode(response.body);
        print(response.body);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Error in removing item from cart'),
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
            content: Text('Error in removing item from cart'),
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
  void getUpdatedTotal(double total){
    totalInCart = total;
    emit(CartGetUpdatedTotalState());
  }
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
        emit(CartSuccessfulGetSpecificProductState());
      } else {
        throw 'Failed to load specific book. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load specific book: $e';
    }
  }
  bool changeState = true;
}