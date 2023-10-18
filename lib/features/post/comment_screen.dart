import 'dart:convert';
import 'package:ecommerce_eraasoft/constants/constants.dart';
import 'package:ecommerce_eraasoft/features/post/cubit/post_cubit.dart';
import 'package:ecommerce_eraasoft/features/post/cubit/post_states.dart';
import 'package:ecommerce_eraasoft/services/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../models/models.dart';

class PostDetailsScreen extends StatelessWidget {
  final PostModel model;
  const PostDetailsScreen({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit,PostStates>(
      listener: (context,state){},
      builder: (context,state){
        ScreenSize.init(context);
        PostCubit cubit = PostCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text('Post Details'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: 20,
                        child: Text(
                          model.title.substring(0, 1),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    model.title,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  width: ScreenSize.screenWidth*0.6,
                                ),
                                Text(
                                  model.userId.toString(),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    model.body,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Comments',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey[500],
                      height: 10,
                      thickness: 1,
                    ),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: cubit.commentsList.length,
                    itemBuilder: (context, index) {
                      final comment = cubit.commentsList[index];
                      print('Comments: $comment');
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 20,
                          child: Text(
                            comment.user.username.substring(0, 1),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              comment.user.username,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),

                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              comment.body,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Add a comment',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send,color: defaultColor),
                        onPressed: (){
                            cubit.addCommentFromButton(model.id,context);
                        },
                      ),
                    ),
                    controller: cubit.commentController,
                    onSubmitted: (value){
                      cubit.addComment(model.id,value,context);
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
