// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:pets_ecommerce/configuration/constants/gradient.dart';
// import 'package:pets_ecommerce/configuration/constants/text_style.dart';
// import 'package:pets_ecommerce/configuration/printer.dart';
// import 'package:pets_ecommerce/configuration/size_config.dart';
// import 'package:pets_ecommerce/screens/auth/controller/services/auth_services.dart';
// import 'package:pets_ecommerce/screens/auth/model/user.dart';
// import 'package:pets_ecommerce/screens/auth/view/register/register_screen.dart';
// import 'package:pets_ecommerce/screens/corner/model/corner_model.dart';
// import 'package:pets_ecommerce/screens/home/view/components/search_bar_component.dart';
// import 'package:pets_ecommerce/screens/stores/view/components/vertical_store_list_card.dart';
// import 'package:pets_ecommerce/screens/widgets/text_field.dart';
// import 'package:pets_ecommerce/screens/corner/view/components/vertical_corner_card.dart';
// import 'package:http/http.dart' as http;
// import 'package:pets_ecommerce/services/http_requests_service.dart';
// import '../controller/my_corners_controller.dart';
// import 'package:get/get.dart';
// import './components/my_corner_vertical_card.dart';
// import '../view/add_corner_screen.dart';
// import 'package:pets_ecommerce/screens/widgets/drawer/custom_drawer.dart';
// class MyCornerList extends StatefulWidget {
//   @override
//   _MyCornerListState createState() => _MyCornerListState();
// }
// MyCornersListController cornerController;
// class _MyCornerListState extends State<MyCornerList> {
//
//   @override
//   void initState() {
//
//     // TODO: implement initState
//     super.initState();
//     consolePrint("in int state");
//     cornerController=Get.put(MyCornersListController());
//   }
//   @override
//   Widget build(BuildContext context) {
//     return
//       // error?Container(height: getProportionateScreenHeight(400),width: getProportionateScreenWidth(400),
//       // child: Center(child: AutoSizeText("عذراً لقد حدثت مشكلة الرجاء المحاولة لاحقاً"),),):loading?LoadingScreen():
//      Scaffold(
//        endDrawer: CustomDrawer(),
//        floatingActionButton: Container(
//          width: 56,
//          height: 56,
//          decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(50),
//              gradient: blueGradient
//          ),
//          child: GestureDetector(
// onTap: (){
//   Get.to(AddCornerScreen(cornerController));
// },
//            // onTap: animate,
//            child: Icon(
//              Icons.add,
//              color: Colors.white,
//            ),
//          ),
//        ),
//        body: Builder(
//          builder: ((context)=> SafeArea(
//            child: Column(
//              children: [
//                Directionality(
//                  textDirection: TextDirection.rtl,
//                  child: Container(
//                    child: Material(
//                      elevation: 5,
//                      color: Colors.white,
//                      child: Container(
//                          width: SizeConfig.screenWidth,
//                          height: getProportionateScreenHeight(95),
//                          child: Row(
//                            children: [
//                              SizedBox(
//                                width: getProportionateScreenWidth(24),
//                              ),
//                              GestureDetector(
//                                onTap: (){ Scaffold.of(context).openEndDrawer();},
//                                child: CircleAvatar(
//                                  radius: 24,
//                                  backgroundColor: Colors.grey.shade50,
//                                  child: Image.asset(
//                                    "assets/images/home/menu_icon.png",
//                                    height: 24,
//                                    width: 20,
//                                  ),
//                                ),
//                              ),
//                              Spacer(),
//                              Container(
//                                  height: getProportionateScreenHeight(28),
//                                  width: getProportionateScreenWidth(75),
//                                  child: AutoSizeText(
//                                    "زاويتي",
//                                    style: h5_21pt,
//                                    minFontSize: 8,
//                                  )),
//                              Spacer(),
//                              CircleAvatar(
//                                radius: 24,
//                                backgroundColor: Colors.grey.shade50,
//                                child: Image.asset(
//                                  "assets/images/home/notification_icon.png",
//                                  height: 24,
//                                  width: 20,
//                                ),
//                              ),
//                              SizedBox(
//                                width: getProportionateScreenWidth(24),
//                              ),
//                            ],
//                          )),
//                    ),
//                  ),
//                ),
//                ///appBAr
//                ///
//                Container(
//                  child: GetBuilder<MyCornersListController>(
//                    init: cornerController,
//                    builder:(controller)=> controller.loading?Container(height:getProportionateScreenHeight(500),child: LoadingScreen()):Expanded(
//                      // margin: EdgeInsets.only(bottom: getProportionateScreenHeight(100)),
//                        child: Container(
//                          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(16),vertical: getProportionateScreenHeight(16)),
//                          child: ListView.builder(
//                            // physics: NeverScrollableScrollPhysics(),
//                              itemCount: controller.corners.length,
//                              itemBuilder: (context, index) =>
//                                  MyCornerVerticalCard(controller.corners[index],()async{await controller.deleteCorner(cornerController.corners[index].id);})),
//                        )),
//                  ),
//                ),
//              ],
//            ),
//          )),
//        )
//
//
//
//      );
//   }
// }
