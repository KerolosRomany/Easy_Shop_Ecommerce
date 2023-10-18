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

class CheckoutComponent extends StatelessWidget {
  final CartItemModel model;
  const CheckoutComponent({super.key,
    required this.model});

  @override
  Widget build(BuildContext context) {
   // print(model.image);
    return BlocConsumer<CartCubit,CartStates>(
      listener: (context,state){},
      builder: (context,state){
        ScreenSize.init(context);
        CartCubit cubit = CartCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
              // height: ScreenSize.screenHeight*0.12,
              width: double.infinity,
              decoration: BoxDecoration(

                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: ScreenSize.screenHeight*0.01),
                      Container(
                        width: ScreenSize.screenWidth*0.6,
                        child: Text(model.title, maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                      SizedBox(height: ScreenSize.screenHeight*0.03),
                      Container(
                        width: ScreenSize.screenWidth*0.4,
                        child: Text('Quantity: ${model.quantity.toString()}', maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey
                            )),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(model.total.toString(), maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                ],
              )
          ),
        );
      },
    );
  }
}
