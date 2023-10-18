import 'dart:convert';

import  'package:bloc/bloc.dart';
import 'package:ecommerce_eraasoft/features/cart/cart_screen.dart';
import 'package:ecommerce_eraasoft/features/products/cubit/products_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/constants.dart';
import '../../../models/models.dart';
import '../specific_book_screen.dart';
import 'package:http/http.dart' as http;
class ProductsCubit extends Cubit<ProductsStates> {

  ProductsCubit() : super(InitialProductsState());

  static ProductsCubit get(context) => BlocProvider.of(context);
  List<ProductModel> productsList=[];
  List<ProductModel> booksSearched=[];
  TextEditingController searchController = TextEditingController();
  bool openSearch = false ;
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
        print(products);
        productsList=products;
        emit(HomeSuccessfulGetAllProductsState());
      } else {
        throw 'Failed to load books. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load books: $e';
    }
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
        emit(ProductsSuccessfulGetSpecificBookState());
      } else {
        throw 'Failed to load specific book. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load specific book: $e';
    }
  }
  Future<void> search(value) async {
    try {
      final url = Uri.parse('$baseUrl/products/search?q=$value');
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
        booksSearched = products;
        emit(ProductsSuccessfulGetResultsFromSearch());
      } else {
        throw 'Failed to load books. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load books: $e';
    }
  }
  List<CartItemModel> cartProducts=[];
  double? totalInCart;
  // Future<void> addToCart(int productId,BuildContext context) async {
  //   int quantity= 1;
  //   final url = Uri.parse('$baseUrl/carts/add');
  //   final Map<String, dynamic> data ={
  //     'userId': userId,
  //     'products': [
  //       {
  //         'id': productId,
  //         'quantity': quantity,
  //       }
  //     ]
  //   };
  //   try {
  //     final response = await http.post(url, body: jsonEncode(data),
  //         headers:
  //         {
  //           'Authorization': 'Bearer $authToken',
  //           'Content-Type': 'application/json',
  //         }
  //     );
  //     if (response.statusCode == 201 || response.statusCode == 200) {
  //       print('Success added to cart');
  //       final jsonResponse = json.decode(response.body);
  //       print(jsonResponse);
  //       showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: Text('Successful added'),
  //           content: Text('Success added to cart'),
  //           actions: [
  //             TextButton(
  //               child: Text(
  //                 'OK',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //
  //                } ,
  //               style: ButtonStyle(
  //                 backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //       getCartProducts();
  //       emit(ProductSuccessfullProductAddedState());
  //     }
  //     else if (response.statusCode == 403 || response.statusCode == 401|| response.statusCode == 404 ) {
  //       final jsonResponse = json.decode(response.body);
  //       print(response.body);
  //       showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: Text('Error'),
  //           content: Text('Error in adding product'),
  //           actions: [
  //             TextButton(
  //               child: Text(
  //                 'OK',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               onPressed: () => Navigator.pop(context),
  //               style: ButtonStyle(
  //                 backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //       print(response.statusCode);
  //     }
  //     else if (response.statusCode == 422){
  //       final jsonResponse = json.decode(response.body);
  //       print(response.body);
  //       showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: Text('Error'),
  //           content: Text('Error in adding product'),
  //           actions: [
  //             TextButton(
  //               child: Text(
  //                 'OK',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               onPressed: () => Navigator.pop(context),
  //               style: ButtonStyle(
  //                 backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     }
  //     else {
  //
  //       print(response.statusCode);
  //     }
  //   } catch (error) {
  //     // Error occurred during the HTTP request
  //     print('Error: $error');
  //   }
  // }
  int cartId = 0;
  Future<void> getCartProducts() async {
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
        final double discountedTotal = decodedBody['carts'][0]['discountedTotal'].toDouble();
        cartId = decodedBody['carts'][0]['id'];
        print(data);
        print(cartId);
        final products = data
            .map<CartItemModel>((json) => CartItemModel.fromJson(json))
            .toList();
        cartProducts=products;
        totalInCart=discountedTotal;
        emit(ProductsSuccessfulGetCartProductsState());
      } else {
        throw 'Failed to load cart products. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load cart products: $e';
    }
  }
  List<CartItemModel> productsAddedToCart=[];
  Future<void> addToCart(int cartId,int productId, BuildContext context) async {
    print(cartId);
    bool isExist =false;
    final url = Uri.parse('$baseUrl/carts/$cartId');
    final Map<String, dynamic> data ={
      'products': [
        {
          'id': productId,
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
        final List<dynamic> data = jsonResponse['products'];
        print(data);
        final productAdded = data
            .map<CartItemModel>((json) => CartItemModel.fromJson(json))
            .first;
          for (var product in productsAddedToCart){
            if (product.id == productAdded.id ){
              print('object');
              product.quantity = product.quantity + 1;
              product.total =  product.quantity*  product.price;
              product.discountedPrice = product.total - (product.total * (product.discountPercentage/100) );
              isExist = true;
            }
          }
        if (!isExist){
          productsAddedToCart.add(productAdded);
        }
        print('Products Added: ');
        for (var product in productsAddedToCart) {
          print(product);
        }
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Successful added'),
            content: Text('Successful added product item to cart'),
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
        emit(ProductsSuccessfullAddToCartState());
      }
      else if (response.statusCode == 403 || response.statusCode == 401 || response.statusCode == 404) {
        final jsonResponse = json.decode(response.body);
        final message = jsonResponse['message'];
        print(response.body);

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Error in adding item from cart'),
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

  Icon favoriteIcon = Icon(Icons.favorite_border);
  bool favoriteIconBoolean = false;
  Icon checkFavIcon(){
    if (favoriteIconBoolean == true) {
      favoriteIcon = Icon(Icons.favorite);
      return favoriteIcon;
      // emit(SuccessfulAddFavoriteState());
    } else {
      favoriteIcon = Icon(Icons.favorite_border);
      return favoriteIcon;
      // emit(SuccussfulRemoveFromFavState());
    }
  }
}