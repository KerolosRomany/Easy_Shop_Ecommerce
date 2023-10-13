import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_eraasoft/constants/constants.dart';
import 'package:ecommerce_eraasoft/features/home/cubit/home_cubit.dart';
import 'package:ecommerce_eraasoft/features/home/cubit/home_states.dart';
import 'package:ecommerce_eraasoft/features/login/login_screen.dart';
import 'package:ecommerce_eraasoft/models/models.dart';
import 'package:ecommerce_eraasoft/services/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/category_component.dart';
import 'components/item_component.dart';

class CategoryProductsScreen extends StatelessWidget {
  final List<ProductModel> categoryProducts;
  final String categoryTitle;
  const CategoryProductsScreen({super.key,required this.categoryTitle,required this.categoryProducts});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          ScreenSize.init(context);
          HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child:
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 5 / 6,
                            crossAxisCount: 2,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 15,
                          ),
                          itemCount: categoryProducts.length,
                          itemBuilder: (BuildContext context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0),
                              child: ItemComponent(
                                model:
                                categoryProducts[index],
                              ),
                            );
                          }
                      ),
                    ],
                  ),
                ),
              ),

            ),
          );
        });
  }

}
