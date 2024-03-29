import 'package:flutter/material.dart';
import 'package:pets/screens/main_screen/controller/title_controller.dart';

TabController bottomTabController;
TextStyle activeTextStyle = TextStyle(color: Colors.blue, fontSize: 12);
TextStyle notActiveTextStyle = TextStyle(color: Colors.grey, fontSize: 12);

TextStyle homeStyle;
TextStyle storesStyle;
TextStyle ordersStyle;
TextStyle doctorsStyle;
TextStyle cornersStyle;

String activeString = "";
String notActiveString = "";
String home = "";
String stores = "";
String orders = "";
String doctors = "";
String corners = "";

String naHome = "assets/images/bottom_navigation_bar/navigation_home_icon.png";
String naOrders =
    "assets/images/bottom_navigation_bar/navigation_oreders_icon.png";
String naDoctors =
    "assets/images/bottom_navigation_bar/navigation_doctor_icon.png";
String naStores =
    "assets/images/bottom_navigation_bar/navigation_store_icon.png";
String naCorners = "assets/images/bottom_navigation_bar/corner.png";

String aHome =
    "assets/images/bottom_navigation_bar/navigation_selected_home_icon.png";
String aOrders =
    "assets/images/bottom_navigation_bar/navigation_selected_oreders_icon.png";
String aDoctors =
    "assets/images/bottom_navigation_bar/navigation_selected_doctor_icon.png";
String aStores =
    "assets/images/bottom_navigation_bar/navigation_selected_store_icon.png";
String aCorners = "assets/images/bottom_navigation_bar/selected_corner.png";

CustomTitle customTitle;
