import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:linuxcommand/screen/login.dart';
import 'package:linuxcommand/screen/registeration.dart';
import 'package:page_transition/page_transition.dart';


class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "ssasss",
        home: AnimatedSplashScreen(
          duration: 2000,
          splash: Image.asset("assets/img/logo.png"),
          nextScreen: MainScreen(),
          splashTransition: SplashTransition.scaleTransition,
          pageTransitionType: PageTransitionType.leftToRightWithFade,
          backgroundColor: Colors.red.shade800,
        ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Register();
  }
}