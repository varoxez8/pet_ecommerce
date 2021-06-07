import 'package:flutter/material.dart';
import 'package:pets_ecommerce/configuration/size_config.dart';
import 'package:get/get.dart';

import 'auth_1.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Duration duration=Duration(seconds: 5);
    Future.delayed(duration).then((value) =>Get.to(WelcomeScreen()));
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(top: getProportionateScreenHeight(210),
              height: getProportionateScreenHeight(412),
              width: SizeConfig.screenWidth,
              child: Container(child: Image.asset(
                  "assets/images/splash_screen/white_logo.png"),
                  ),)
          ],
        ),
      ),
    );
  }
}