import 'package:ecommerce_eraasoft/features/books/cubit/books_cubit.dart';
import 'package:ecommerce_eraasoft/features/books/cubit/books_state.dart';
import 'package:ecommerce_eraasoft/services/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/book_component.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    ProductsCubit.get(context).getProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit,ProductsStates>(
        builder: (context,state){
          ScreenSize.init(context);
          ProductsCubit cubit = ProductsCubit.get(context);
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SearchBar(
                    leading: Icon(Icons.search),
                    controller: cubit.searchController,
                    hintText: 'Search',
                    hintStyle: MaterialStateProperty.resolveWith<TextStyle>(
                          (Set<MaterialState> states) {
                        return TextStyle(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w600
                        );
                      },
                    ),
                    onTap: (){
                      cubit.openSearch =true;
                    },
                    backgroundColor:  MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        return Colors.grey.shade200;
                      },
                    ),
                    onChanged: (value){
                      cubit.search(value);
                    },
                    trailing: [
                      IconButton(onPressed: (){
                        if (cubit.booksSearched == []){
                          cubit.searchController.clear();
                          cubit.openSearch = false;
                        }
                          else
                          {
                            cubit.searchController.clear();
                            cubit.openSearch = false;
                            cubit.getProducts();
                          }

                      }, icon: Icon(Icons.clear) )
                    ],

                  ),
                ),
              cubit.openSearch == true ?
                Container(
                  height:
                  ScreenSize.screenHeight * 0.7,
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context,
                          index) => BookComponent(model: cubit.booksSearched[index] ,),
                      separatorBuilder:
                          (context, index) =>
                          SizedBox(
                            height: ScreenSize
                                .screenHeight *
                                0.01,
                          ),
                      itemCount: cubit.booksSearched.length),
                ) :
              Container(
                height:
                ScreenSize.screenHeight * 0.7,
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context,
                        index) => BookComponent(model: cubit.productsList[index] ,),
                    separatorBuilder:
                        (context, index) =>
                        SizedBox(
                          height: ScreenSize
                              .screenHeight *
                              0.01,
                        ),
                    itemCount: cubit.productsList.length),
              ) ,
              ],
            ),
          ),
        ),

      );
    });
  }
}
