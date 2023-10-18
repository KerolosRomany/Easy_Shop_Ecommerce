import 'package:ecommerce_eraasoft/constants/constants.dart';
import 'package:ecommerce_eraasoft/features/products/cubit/products_cubit.dart';
import 'package:ecommerce_eraasoft/features/products/cubit/products_state.dart';
import 'package:ecommerce_eraasoft/features/home/cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../services/screen_size.dart';

class ProductComponent extends StatefulWidget {
  final ProductModel model;
  const ProductComponent({super.key,
  required this.model});

  @override
  State<ProductComponent> createState() => _ProductComponentState();
}

class _ProductComponentState extends State<ProductComponent> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   // print(model.image);

    return BlocConsumer<ProductsCubit,ProductsStates>(
      listener: (context,state){},
      builder: (context,state){
        ScreenSize.init(context);
        ProductsCubit cubit = ProductsCubit.get(context);
        cubit.favoriteIconBoolean =false;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
              height: ScreenSize.screenHeight*0.2,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: MaterialButton(
                onPressed: (){
                  cubit.getSpecificProduct(widget.model.id.toString(),context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Container(
                            width: ScreenSize.screenWidth*0.3,
                            height: ScreenSize.screenHeight*0.15,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(image: NetworkImage(widget.model.images[0],),fit: BoxFit.contain,),)
                        ),
                        Container(
                          width: ScreenSize.screenWidth*0.14,
                          height: ScreenSize.screenHeight*0.04,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: defaultColor
                          ),
                          child: Center(child: Text('${widget.model.discountPercentage.round()}%',style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 13
                          ),)),
                        ),
                      ],
                    ),
                    SizedBox(width: ScreenSize.screenWidth*0.01),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: ScreenSize.screenHeight*0.01),
                        Container(
                          width: ScreenSize.screenWidth*0.4,
                          child: Text(widget.model.title, maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              )),
                        ),
                        SizedBox(height: ScreenSize.screenHeight*0.01),
                        Text(widget.model.category, maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey
                            )),
                        SizedBox(height: ScreenSize.screenHeight*0.01),
                        Text('${(widget.model.price - widget.model.price * (widget.model.discountPercentage/100)).round() } \$', maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.green
                            )),
                      ],
                    ),
                    Spacer(),
                    IconButton(onPressed: (){
                      cubit.addToCart(cubit.cartId,widget.model.id, context);
                    }, icon: Icon(Icons.add_shopping_cart)),
                  ],
                ),
                padding: EdgeInsets.zero,
              )
          ),
        );
      },
    );
  }
}

