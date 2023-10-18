
import 'package:ecommerce_eraasoft/components/components.dart';
import 'package:ecommerce_eraasoft/constants/constants.dart';
import 'package:ecommerce_eraasoft/features/products/cubit/products_cubit.dart';
import 'package:ecommerce_eraasoft/models/models.dart';
import 'package:ecommerce_eraasoft/services/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../checkout/checkout_screen.dart';
import 'components/cart_item_component.dart';
import 'cubit/cart_cubit.dart';
import 'cubit/cart_states.dart';

class CartScreen extends StatefulWidget {
  List<CartItemModel> productsAddedToCart;
  CartScreen({super.key,required this.productsAddedToCart});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    widget.productsAddedToCart = ProductsCubit.get(context).productsAddedToCart;
    if (widget.productsAddedToCart.isNotEmpty) {
      List<CartItemModel> productsToRemove = [];

      for (var product in widget.productsAddedToCart) {
        if (product.quantity == 0) {
          productsToRemove.add(product);
        }
      }

      for (var product in productsToRemove) {
        widget.productsAddedToCart.remove(product);
      }

      CartCubit.get(context).getCartProducts(widget.productsAddedToCart);
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit,CartStates>(
        builder: (context,state){
          ScreenSize.init(context);
          CartCubit cubit = CartCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: widget.productsAddedToCart.length != 0 ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height:
                        ScreenSize.screenHeight * 0.7,
                        child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context,
                                index) => CartItemComponent(model: cubit.cartProducts[index] ,),
                            separatorBuilder:
                                (context, index) =>
                                SizedBox(
                                  height: ScreenSize
                                      .screenHeight *
                                      0.0001,
                                ),
                            itemCount: cubit.cartProducts.length),
                      ) ,
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          width: double.infinity,
                          height: ScreenSize.screenHeight*0.12,
                          decoration: BoxDecoration(
                            color: defaultColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Total price: ${cubit.totalInCart.toInt()}',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700
                                  ),),
                                  Spacer(),
                                  smalldefaultButton(text: 'Checkout',
                                      onpressed: (){
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=> CheckoutScreen()));
                                      }, color: Colors.white, context: context,textColor: defaultColor)
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ) :
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: ScreenSize.screenWidth*0.6,
                          child: Image(image:AssetImage('assets/images/logo.png'))),
                      SizedBox(height: ScreenSize.screenHeight*0.01,),
                      Text('Empty cart',style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      ),),
                      SizedBox(height: ScreenSize.screenHeight*0.03,),
                      Text('Add a products to the cart and checkout',style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500
                      ),),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
