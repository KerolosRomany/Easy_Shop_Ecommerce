import 'dart:convert';

import  'package:bloc/bloc.dart';
import 'package:ecommerce_eraasoft/features/cart/cart_screen.dart';
import 'package:ecommerce_eraasoft/features/post/cubit/post_states.dart';
import 'package:ecommerce_eraasoft/features/post/post_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/constants.dart';
import '../../../models/models.dart';
import 'package:http/http.dart' as http;
class PostCubit extends Cubit<PostStates> {

  PostCubit() : super(InitialPostState());

  static PostCubit get(context) => BlocProvider.of(context);

  List<PostModel> postsList=[];
  List<PostModel> userPostsList=[];
  bool isAddingPost = true;
  TextEditingController postController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  var addPostKey = GlobalKey<FormState>();
  Future<void> getPosts() async {
    try {
      final url = Uri.parse('$baseUrl/posts');
      final response = await http.get(url,
          headers:
          {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken'
          });

      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        print(decodedBody);
        final List<dynamic> data = decodedBody['posts'];
        print(data);
        final posts = data
            .map<PostModel>((json) => PostModel.fromJson(json))
            .toList();
        postsList=posts;
        emit(PostSuccessfulGetPostsState());
      } else {
        throw 'Failed to load posts. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load posts: $e';
    }
  }
  Future<void> getUserPosts() async {
    try {
      final url = Uri.parse('$baseUrl/users/$userId/posts');
      final response = await http.get(url,
          headers:
          {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken'
          });

      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        print(decodedBody);
        final List<dynamic> data = decodedBody['posts'];
        print(data);
        final posts = data
            .map<PostModel>((json) => PostModel.fromJson(json))
            .toList();
        userPostsList=posts;
        emit(PostSuccessfulGetUserPostsState());
      } else {
        throw 'Failed to load posts. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load posts: $e';
    }
  }
  String username = '';
  // Future<void> addPost(int productId,BuildContext context) async {
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
  //               } ,
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

  List<CommentModel> commentsList = [];
  final TextEditingController commentController = TextEditingController();

  Future<void> addPost(BuildContext context) async {
    final url = Uri.parse('$baseUrl/posts/add');
    final Map<String, dynamic> data ={
      'title': titleController.text,
      'body': postController.text,
      'userId': int.parse(userId),
      "tags": [
        tagsController.text

      ],
      "reactions": 0
    };
    try {
      final response = await http.post(url, body: jsonEncode(data),
          headers:
          {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          }
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Success posted');
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        // final data = jsonResponse;
        // print(data);
        final post = PostModel.fromJson(jsonResponse);

        print(post);
        // postsList.add(post);
        postsList.insert(0, post);
        userPostsList.insert(0, post);
        print(jsonResponse);
        // final double discountedTotal = jsonResponse['discountedTotal'].toDouble();
        // totalInCart = discountedTotal;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Successful'),
            content: Text('Success posted'),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> FeedScreen())),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
                ),
              ),
            ],
          ),
        );
        emit(PostSuccessfulAddPostState());
      }
      else if (response.statusCode == 403 || response.statusCode == 401) {
        final jsonResponse = json.decode(response.body);
        print(response.body);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Error in adding post'),
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
            content: Text('Error in adding post'),
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

  Map<int,CommentModel> insertedComments = {

  };
  Future<void> getPostComments(int postId) async {
    try {
      final url = Uri.parse('$baseUrl/posts/$postId/comments');
      final response = await http.get(url,
          headers:
          {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken'
          });

      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        print(decodedBody);
        final List<dynamic> data = decodedBody['comments'];
        print(data);
        final comments = data
            .map<CommentModel>((json) => CommentModel.fromJson(json))
            .toList();
        commentsList=comments;
        if (insertedComments.containsKey(postId)){
          commentsList.insert(0,insertedComments[postId]!);
        }
        print(commentsList);
        emit(PostSuccessfulGetUserPostCommentsState());
      } else {
        throw 'Failed to load comments. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load comments: $e';
    }
  }
  Future<void> addComment(int postId,String body,BuildContext context) async {
    final url = Uri.parse('$baseUrl/comments/add');
    final Map<String, dynamic> data ={
      'body': body,
      'postId': postId,
      'userId': userId,
    };
    try {
      final response = await http.post(url, body: jsonEncode(data),
          headers:
          {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          }
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Success commented');
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        // final data = jsonResponse;
        // print(data);
        final comment = CommentModel.fromJson(jsonResponse);
        print(comment);
        insertedComments.addAll({
          comment.postId: comment
        });
        commentsList.add(comment);
        print(jsonResponse);
        // final double discountedTotal = jsonResponse['discountedTotal'].toDouble();
        // totalInCart = discountedTotal;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Successful'),
            content: Text('Success commented'),
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
        emit(PostSuccessfulAddCommentState());
      }
      else if (response.statusCode == 403 || response.statusCode == 401) {
        final jsonResponse = json.decode(response.body);
        print(response.body);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Error in adding comment'),
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
            content: Text('Error in adding comment'),
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
  void addCommentFromButton(int postId,BuildContext context) {
    final comment = commentController.text;
    addComment(postId,comment,context);
    // PostCubit.get(context).getPostComments(widget.model.id);
    commentController.clear();
  }
}