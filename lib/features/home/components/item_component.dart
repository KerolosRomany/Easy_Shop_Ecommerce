import 'package:ecommerce_eraasoft/features/home/cubit/home_cubit.dart';
import 'package:ecommerce_eraasoft/features/home/cubit/home_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../services/screen_size.dart';

class ItemComponent extends StatelessWidget {
  final ProductModel model;
  const ItemComponent({super.key,
  required this.model});

  @override
  Widget build(BuildContext context) {
   // print(model.image);
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        HomeCubit cubit = HomeCubit.get(context);
        return Container(
            height: ScreenSize.screenHeight*0.4,
            width: ScreenSize.screenWidth*0.4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: (){
                  cubit.getSpecificProduct(model.id.toString(),context);
                },
                child: Column(
                  children: [
                    Container(
                        width: ScreenSize.screenWidth*0.3,
                        height: ScreenSize.screenHeight*0.15,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(image: NetworkImage(model.images[0],),fit: BoxFit.contain,),)
                    ),

                    // child: Image.network(model.image,fit: BoxFit.contain,)),
                    SizedBox(height: ScreenSize.screenHeight*0.01),
                    Text(model.title, maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        )),
                    SizedBox(height: ScreenSize.screenHeight*0.005),
                    Text(model.category, maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey
                        )),

                    Text('${(model.price - model.price * (model.discountPercentage/100)).round() } \$', maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.green
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
