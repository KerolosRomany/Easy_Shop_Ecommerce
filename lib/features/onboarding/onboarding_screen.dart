
import 'package:ecommerce_eraasoft/features/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';

import '../register/register_screen.dart';



class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late Material materialButton;
  late int index;
  @override
  void initState() {
    super.initState();
    materialButton = _skipButton();
    index = 0;
  }
  Material get _signupButton {
    return Material(
      borderRadius: defaultProceedButtonBorderRadius,
      color: const Color(0xff174068),
      child: InkWell(
        borderRadius: defaultProceedButtonBorderRadius,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return const LoginScreen();
          }));
        },
        child: const Padding(
          padding: defaultProceedButtonPadding,
          child: Text(
            'Login',
            style:TextStyle(
                color: Colors.white,
                letterSpacing: 1.0,
                fontWeight: FontWeight.w700
            ),
          ),
        ),
      ),
    );
  }
  Material _skipButton({void Function(int)? setIndex}) {
    return Material(
      borderRadius: defaultSkipButtonBorderRadius,
      color: defaultSkipButtonColor,
      child: InkWell(
        borderRadius: defaultSkipButtonBorderRadius,
        onTap: () {
          if (setIndex != null) {
            index = 2;
            setIndex(2);
          }
        },
        child: const Padding(
          padding: defaultSkipButtonPadding,
          child: Text(
            'Skip',
            style: defaultSkipButtonTextStyle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //ScreenSize.init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Onboarding(pages: [
          PageModel(
            widget: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height *0.4,
                    child: const Image(image: AssetImage('assets/images/1.jpg',)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Welcome to Easy shop!',
                        style: TextStyle(
                          color: Color(0xff174068),
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Shop for everything you need, in one place. '
                            '\n\nFind the latest products from top brands.'
                            '\n\nEnjoy a convenient and hassle-free shopping experience with our easy-to-use app.',
                        style: TextStyle(
                          color: Color(0xff030E19),
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          PageModel(
            widget: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.4,
                    child: const Image(image: AssetImage('assets/images/2.jpg',)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sale on Everything!',
                        style: TextStyle(
                          color: Color(0xff174068),
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Find the latest trends at the best prices. '
                            '\n\nDon\'t miss out on these incredible savings.'
                            '\n\nGet ready for the season with our latest sale',
                        style: TextStyle(
                          color: Color(0xff030E19),
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          PageModel(
            widget: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.4,
                    child: const Image(image: AssetImage('assets/images/3.jpg',)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Review Your Order',
                        style: TextStyle(
                          color: Color(0xff174068),
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'See what\'s in your cart and make any changes before you checkout. '
                            '\n\nConfirm your order details and shipping information.'
                            '\n\nThank you for shopping with us! We\'re excited to get your order on its way.',
                        style: TextStyle(
                          color: Color(0xff030E19),
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
          onPageChange: (int pageIndex) {
            index = pageIndex;
          },
          startPageIndex: 0,
          footerBuilder: (context, dragDistance, pagesLength, setIndex) {
            return DecoratedBox(
              decoration: const BoxDecoration(
                color: Color(0xff174068),
              ),
              child: ColoredBox(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(45.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIndicator(
                        netDragPercent: dragDistance,
                        pagesLength: pagesLength,
                        indicator: Indicator(
                            indicatorDesign: IndicatorDesign.polygon(
                              polygonDesign: PolygonDesign(polygon: DesignType.polygon_circle),
                            ),
                            activeIndicator: ActiveIndicator(
                              borderWidth: MediaQuery.of(context).size.width*0.005,
                              color: const Color(0xff174068),
                            ),
                            closedIndicator: ClosedIndicator(
                              borderWidth: MediaQuery.of(context).size.width*0.005,
                              color: const Color(0xff174068),
                            )
                        ),
                      ),
                      index == pagesLength - 1
                          ? _signupButton
                          : _skipButton(setIndex: setIndex)
                    ],
                  ),
                ),
              ),
            );
          },

        )


    );
  }
}