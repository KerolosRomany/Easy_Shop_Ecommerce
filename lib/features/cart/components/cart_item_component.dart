import 'package:ecommerce_eraasoft/constants/constants.dart';
import 'package:ecommerce_eraasoft/features/cart/cubit/cart_cubit.dart';
import 'package:ecommerce_eraasoft/features/cart/cubit/cart_cubit.dart';
import 'package:ecommerce_eraasoft/features/cart/cubit/cart_cubit.dart';
import 'package:ecommerce_eraasoft/features/cart/cubit/cart_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../services/screen_size.dart';

class CartItemComponent extends StatefulWidget {
  final CartItemModel model;
  const CartItemComponent({super.key,
  required this.model});

  @override
  State<CartItemComponent> createState() => _CartItemComponentState();
}

class _CartItemComponentState extends State<CartItemComponent> {

  @override
  Widget build(BuildContext context) {
   // print(model.image);
    return BlocConsumer<CartCubit,CartStates>(
      listener: (context,state){},
      builder: (context,state){
        ScreenSize.init(context);
        CartCubit cubit = CartCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: MaterialButton(

            onPressed: (){
              cubit.getSpecificProduct(widget.model.id.toString(),context);
            },
            // padding: EdgeInsets.zero,
            child: widget.model.quantity != 0 ? Container(
                height: ScreenSize.screenHeight*0.2,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: ScreenSize.screenWidth*0.5,
                            child: Text(widget.model.title, maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                )),
                          ),
                          SizedBox(height: ScreenSize.screenHeight*0.03),
                          Container(
                            height: ScreenSize.screenHeight*0.05,
                            width: ScreenSize.screenWidth*0.3,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10)),

                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(onPressed: (){
                                    cubit.addToCart(widget.model.id, widget.model.quantity,context);
                                    setState(() {
                                      widget.model.quantity=widget.model.quantity+1;
                                      widget.model.total =  widget.model.quantity*  widget.model.price;
                                      widget.model.discountedPrice = widget.model.total - (widget.model.total * (widget.model.discountPercentage/100) );
                                      cubit.totalInCart = cubit.totalInCart + (widget.model.price-widget.model.price*(widget.model.discountPercentage/100));
                                      cubit.getUpdatedTotal(cubit.totalInCart);
                                        // cubit.getCartProducts();
                                    });
                                }, icon: Icon(Icons.add)),
                                Text(widget.model.quantity.toString()),
                                IconButton(onPressed: (){
                                  cubit.removeItemFromCart(widget.model.id, widget.model.quantity,context);
                                  setState(() {
                                    widget.model.quantity=widget.model.quantity-1;
                                    widget.model.total =  widget.model.quantity*  widget.model.price;
                                    widget.model.discountedPrice = widget.model.total - (widget.model.total * (widget.model.discountPercentage/100) );
                                    cubit.totalInCart = cubit.totalInCart - (widget.model.price-widget.model.price*(widget.model.discountPercentage/100));

                                    cubit.getUpdatedTotal(cubit.totalInCart);
                                    // cubit.getCartProducts();
                                  });
                                }, icon: Icon(Icons.remove)),
                              ],
                            ),
                          )
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(onPressed: (){
                              cubit.removeProductFromCart(cubit.cartId,widget.model.id, widget.model.quantity,context);
                              setState(() {
                                cubit.totalInCart = cubit.totalInCart - ((widget.model.price*widget.model.quantity)-(widget.model.price*widget.model.quantity)*(widget.model.discountPercentage/100));
                                print(cubit.totalInCart );
                                widget.model.quantity = 0;
                                // if (cubit.cartProducts.contains(widget.model)){
                                //   cubit.cartProducts.remove(widget.model);
                                // }
                                cubit.getUpdatedTotal(cubit.totalInCart);
                              });
                            }, icon: Icon(Icons.delete,color: Colors.red.shade900,)),
                            Spacer(),

                            Text('Sale ${widget.model.discountPercentage.toString()}%', maxLines: 1,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                )),
                            SizedBox(height: ScreenSize.screenHeight*0.01),
                            Text('Per one: ${widget.model.price.round()} \$', maxLines: 1,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                )),
                            SizedBox(height: ScreenSize.screenHeight*0.01),
                            Container(
                              width: ScreenSize.screenWidth*0.25,
                              child: Text('Price: ${widget.model.discountedPrice.round()} \$', maxLines: 2,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
            ) : Padding(padding: EdgeInsets.zero)
          ),
        );
      },
    );
  }
}
