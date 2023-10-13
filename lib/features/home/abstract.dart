import 'package:ecommerce_eraasoft/constants/constants.dart';
import 'package:ecommerce_eraasoft/features/home/cubit/home_cubit.dart';
import 'package:ecommerce_eraasoft/features/home/cubit/home_states.dart';
import 'package:ecommerce_eraasoft/services/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbstractScreen extends StatelessWidget {
  const AbstractScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit,HomeStates>(builder: (context,state){
      ScreenSize.init(context);
      HomeCubit cubit = HomeCubit.get(context);
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          onTap: cubit.onTabTapped,
          selectedItemColor: defaultColor,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.post_add),
              label: 'Posts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
        body: cubit.screens[cubit.currentIndex],
      );
    });
  }
}
