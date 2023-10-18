import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_eraasoft/components/components.dart';
import 'package:ecommerce_eraasoft/features/books/cubit/books_cubit.dart';
import 'package:ecommerce_eraasoft/models/models.dart';
import 'package:ecommerce_eraasoft/services/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/books_state.dart';

class SpecificBookScreen extends StatelessWidget {
  final ProductModel product;
  const SpecificBookScreen({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit,ProductsStates>(
      listener: (context,state){},
      builder: (context,state){
        ScreenSize.init(context);
        ProductsCubit cubit =ProductsCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    // Container(
                    //   width: double.infinity,
                    //   height: ScreenSize.screenHeight*0.4,
                    //   decoration: BoxDecoration(
                    //     image: DecorationImage(image: NetworkImage(product.images[0],),fit: BoxFit.cover)
                    //   ),
                    // ),
                  CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 1,
                      viewportFraction: .9,
                      disableCenter: true,
                      onPageChanged: (index,i) {
                        // cubit.chanegePageIndex(index);
                        // setState(() {
                        //   pageIndex = index;
                        //   print(i);
                        // });
                      },

                    ),

                    items: product.images
                        .map((item) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color:Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                                image: NetworkImage(item,),
                                fit: BoxFit.fitWidth,
                            )
                        ),
                        height: ScreenSize.screenHeight*0.4,
                        width: double.infinity,
                      ),
                    ))
                        .toList(),

                  ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Text(product.title,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700
                                ),),
                                width: ScreenSize.screenWidth*0.6,
                              ),
                              Spacer(),
                              Text('${product.price.toString()} EGP', maxLines: 1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green
                                  )),
                            ],
                          ),
                          SizedBox(height: ScreenSize.screenHeight*0.01,),
                          Text(product.category,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          color: Colors.grey
                  ),),
                          SizedBox(height: ScreenSize.screenHeight*0.01,),
                          Text(product.brand,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey
                          ),),
                          SizedBox(height: ScreenSize.screenHeight*0.01,),
                          Text('Rating: ${product.rating.toString()}',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey
                          ),),
                          SizedBox(height: ScreenSize.screenHeight*0.02,),
                          Text('Description:',style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),),
                          SizedBox(height: ScreenSize.screenHeight*0.01,),

                          Text(product.description,maxLines: 10,overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.grey
                          ),),
                          SizedBox(height: ScreenSize.screenHeight*0.02,),
                          defaultButton(text: 'Add to cart', onpressed: (){
                            cubit.addToCart(product.id,context);

                          })

                        ],
                      ),
                    ),

                ],

              ),
            ),
          ),
        );
      },
    );
  }
}
