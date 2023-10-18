import 'dart:convert';
import 'package:ecommerce_eraasoft/features/post/cubit/post_cubit.dart';
import 'package:ecommerce_eraasoft/features/post/cubit/post_states.dart';
import 'package:ecommerce_eraasoft/features/post/my_posts.dart';
import 'package:ecommerce_eraasoft/services/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../constants/constants.dart';
import '../../models/models.dart';
import 'add_post.dart';
import 'comment_screen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit,PostStates>(
      builder: (context,state){
        PostCubit cubit = PostCubit.get(context);
        ScreenSize.init(context);
        return Scaffold(

          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [


                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPostScreen()));
                          },
                          child: const Text('Add Post'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
                          ),
                        ),
                        SizedBox(width: ScreenSize.screenWidth*0.1),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context)=> MyPostsScreen()));
                          },
                          child: const Text('My posts'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildFeedItem(cubit.postsList[index],cubit,context),
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                        color: Colors.black54,
                      ),
                      itemCount: cubit.postsList.length,
                    ),
                  ),

                ],
              ),
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     setState(() {
          //       cubit.isAddingPost = !cubit.isAddingPost; // Toggle the value of isAddingPost
          //       if (!cubit.isAddingPost) {
          //         cubit.postController.clear(); // Clear the text field when hiding it
          //       }
          //     });
          //   },
          //
          //   child: const Icon(Icons.add),
          //   backgroundColor: defaultColor,
          // ),
        );
      },
    );
  }

  Widget buildFeedItem(PostModel model,PostCubit cubit,BuildContext context) {
    return GestureDetector(
      onTap: () {
        cubit.getPostComments(model.id).then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailsScreen(model: model),
            ),
          );

        }
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
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
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: ScreenSize.screenWidth*0.6,
                      child: Text(
                        model.title,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      model.id.toString(),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              model.body,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              model.tags.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text('${model.reactions} reactions',style: TextStyle(
                  color: defaultColor,
                  fontWeight: FontWeight.w700
                )),
                Spacer(),
                OutlinedButton.icon(
                  onPressed: () {
                    cubit.getPostComments(model.id).then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostDetailsScreen(model: model),
                        ),
                      );

                    }
                    );
                  },
                  icon: const Icon(Icons.edit_note),
                  label: const Text('Comments'),
                  style: ButtonStyle(
                    foregroundColor:
                    MaterialStateProperty.all<Color>(defaultColor),
                    overlayColor: MaterialStateProperty.all<Color>(
                        Colors.blue.withOpacity(0.1)),
                    side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(color: Color(0xff174068))),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
