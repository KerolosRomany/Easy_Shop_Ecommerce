
import 'package:ecommerce_eraasoft/services/bloc_observer.dart';
import 'package:ecommerce_eraasoft/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/cart/cubit/cart_cubit.dart';
import 'features/checkout/cubit/checkout_cubit.dart';
import 'features/home/abstract.dart';
import 'features/home/cubit/home_cubit.dart';
import 'features/login/cubit/login_cubit.dart';
import 'features/login/login_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/post/cubit/post_cubit.dart';
import 'features/products/cubit/products_cubit.dart';
import 'features/register/cubit/register_cubit.dart';
import 'features/register/otp_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(),),
        BlocProvider(create: (context) => RegisterCubit(),),
        BlocProvider(create: (context) => ProductsCubit()..getProducts()..getCartProducts()),
        BlocProvider(create: (context) => HomeCubit().. getProfileDetails()..getProducts(),),
        BlocProvider(create: (context) => CartCubit()..getCartProducts(ProductsCubit.get(context).productsAddedToCart)),
        BlocProvider(create: (context) => PostCubit()..getPosts()..getUserPosts()),
        BlocProvider(create: (context) => CheckoutCubit(CartCubit.get(context).totalInCart).. getProfileDetails()),
      ],
      child: MaterialApp(
        title: 'E-commerce',
        theme: ThemeData(

        ),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

