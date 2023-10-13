import 'package:ecommerce_eraasoft/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../services/screen_size.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_states.dart';

class CategoryComponent extends StatelessWidget {
  final CategoryModel model;
  const CategoryComponent({super.key,
    required this.model});

  @override
  Widget build(BuildContext context) {
    // print(model.image);
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        HomeCubit cubit = HomeCubit.get(context);
        return Container(
            height: ScreenSize.screenHeight*0.3,
            width: ScreenSize.screenWidth*0.3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: (){
                  cubit.getSpecificCategoryProducts(model.title, context);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                        width: ScreenSize.screenWidth*0.25,
                        height: ScreenSize.screenHeight*0.13,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/images/category.jpg',),fit: BoxFit.cover,opacity: 0.5),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        )
                    ),
                    Text(model.title, maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          color: defaultColor,
                          fontWeight: FontWeight.w700,
                        )),
                  ],
                ),
                padding: EdgeInsets.zero,
              ),
            )
        );
      },
    );
  }
}
