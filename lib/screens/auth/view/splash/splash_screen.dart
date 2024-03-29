import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:pets/configuration/size_config.dart';
import 'package:get/get.dart';
import 'package:pets/screens/auth/controller/services/auth_services.dart';
import 'package:pets/screens/auth/model/user.dart';
import 'package:pets/screens/main_screen/view/main_view.dart';
import 'package:pets/screens/widgets/drawer/custom_drawer.dart';
import 'package:pets/services/local_storage_service.dart';
import '../register/register_types_screen.dart';
import 'login_or_register.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    LocalStorageService.getPrefs();
    // AuthServices.getCurrentUser();
    Duration duration = Duration(seconds: 2);
    Future.delayed(duration).then((value) async {
      // var user =await AuthServices.getCurrentUser();
      // bool k=false;
// if(user.error!=true)
      bool k = AuthServices.authenticated();

      k
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => I18n(
                      // initialLocale: Locale('ar'),
                      child: MainScreen())))
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => I18n(
                      // initialLocale: Locale('ar'),
                      child: LoginOrRegister())));
    });
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
            Positioned(
              top: getProportionateScreenHeight(210),
              height: getProportionateScreenHeight(412),
              width: SizeConfig.screenWidth,
              child: Container(
                child:
                    Image.asset("assets/images/splash_screen/white_logo.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
