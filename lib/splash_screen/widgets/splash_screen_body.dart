
import 'package:ecommerce_eraasoft/splash_screen/widgets/sliding_text.dart';
import 'package:flutter/material.dart';
import '../../features/onboarding/onboarding_screen.dart';


class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimations();
    initNavigateToHomeView();

  }
  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  void initSlidingAnimations(){
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 7), end: Offset.zero)
            .animate(animationController);
    animationController.forward();
  }

  void initNavigateToHomeView(){
    Future.delayed(const Duration(seconds: 4),(){
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return const OnBoardingScreen();
      }));
    });
  }


  @override
  Widget build(BuildContext context) {
    return   Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 220,
            width: 190,
            child: Image.asset('assets/images/logo.png',fit: BoxFit.fitWidth),
          ),
          const SizedBox(
            height: 15,
          ),
          SlidingText(slidingAnimation: slidingAnimation),
        ]);
  }
}