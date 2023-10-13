
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
            return const RegisterScreen();
          }));
        },
        child: const Padding(
          padding: defaultProceedButtonPadding,
          child: Text(
            'Register',
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
                        'Welcome to Ketaby!',
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
                        'Explore a world of books at your fingertips. '
                            '\n\nDiscover the latest releases, bestsellers, and hidden gems in every genre.',
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
                    child: const Image(image: AssetImage('assets/images/4.jpg',)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Find Your Next Read',
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
                        'Browse through our vast collection of books, curated with love for all book enthusiasts. '
                            '\n\nPurchase your favorite titles with just a few taps.',
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
                    child: const Image(image: AssetImage('assets/images/5.jpg',)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Immerse Yourself in Books',
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
                        'Dive into captivating stories, expand your knowledge, and embark on incredible journeys through the power of reading. '
                            '\n\nEnjoy a seamless reading experience on any device.',
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