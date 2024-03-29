import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets/configuration/constants/api.dart';
import 'package:pets/configuration/constants/text_style.dart';
import 'package:pets/configuration/printer.dart';
import 'package:pets/configuration/size_config.dart';
import 'package:pets/main.dart';
import 'package:pets/screens/auth/view/register/register_screen.dart';
import 'package:pets/screens/doctor_app/model/doctor.dart';
import 'package:pets/screens/doctors/controllers/customer_doctor_label_controller.dart';
import 'package:pets/services/http_requests_service.dart';
import 'translations/doctor_details.i18n.dart';
import 'components/orders_response/orders_response_body.dart';
import 'components/personal_info/personal_info_body.dart';
import 'components/services/services_body.dart';
import 'package:http/http.dart' as http;

class DoctorDetailsPage extends StatefulWidget {
  int id;

  DoctorDetailsPage(this.id);

  @override
  _DoctorDetailsPageState createState() => _DoctorDetailsPageState();
}

class _DoctorDetailsPageState extends State<DoctorDetailsPage>
    with SingleTickerProviderStateMixin {
  bool loading = false;
  bool error = false;
  DoctorModel doctorModel;

  fetchdata() async {
    loading = true;
    setState(() {});
    consolePrint("befor get ");
    final h = await HttpService().getHeaders();
    final apiResult = await http.get(
        Api.baseUrl + Api.getDoctorId + '/' + widget.id.toString(),
        headers: h);
    consolePrint("after get ");
    if (apiResult.statusCode == 200)
      doctorModel = doctorModelFromJson(apiResult.body);
    else
      error = true;

    loading = false;
    setState(() {});
  }

  TabController _tabController;
  CustomerDoctorDetailsLabelController _customerDoctorDetailsLabelController =
      Get.put(CustomerDoctorDetailsLabelController());

  @override
  void initState() {
    fetchdata();
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      _customerDoctorDetailsLabelController.changeIndex(_tabController.index);
    });
    _tabController.animateTo(1);
    _customerDoctorDetailsLabelController.changeIndex(1);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: SafeArea(
        child: loading
            ? LoadingScreen()
            : Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: getProportionateScreenHeight(400),
                      child: Container(
                        child: doctorModel.doctor.image == null ||
                                doctorModel.doctor.image == ""
                            ? Container(
                                height: getProportionateScreenHeight(400),
                                width: getProportionateScreenWidth(390),
                                color: Colors.white.withOpacity(0.8),
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  "Pets",
                                  style: BlueText_16pt_bold,
                                ))
                            : Image.network(
                                Api.imagePath + doctorModel.doctor.image,
                                fit: BoxFit.cover,
                              ),
                      )),
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: getProportionateScreenHeight(400),
                      child: Container(
                        child: Opacity(
                          opacity: doctorModel.doctor.image == null ||
                                  doctorModel.doctor.image == ""
                              ? 0.4
                              : 1,
                          child: Image.asset(
                            "assets/images/store/black_layer.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      )),
                  Positioned(
                    top: getProportionateScreenHeight(34),
                    left: getProportionateScreenWidth(24),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: getProportionateScreenWidth(48),
                        height: getProportionateScreenHeight(48),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            shape: BoxShape.circle),
                        child: Center(
                          child: RotatedBox(
                            quarterTurns: appLocal == "ar" ? 90 : 0,
                            child: Icon(
                              Icons.arrow_back_ios_outlined,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  appLocal == "ar"
                      ? Positioned(
                          top: getProportionateScreenHeight(290),
                          left: getProportionateScreenWidth(10),
                          child: Container(
                            width: getProportionateScreenWidth(102),
                            height: getProportionateScreenHeight(40),
                            // padding: EdgeInsets.only(top: getProportionateScreenHeight(10),bottom: getProportionateScreenHeight(10),left: getProportionateScreenWidth(15),right:getProportionateScreenWidth(25) ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.white.withOpacity(0.5),
                                Colors.white.withOpacity(0.1),
                              ]),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(12)),
                            ),
                            child: Center(
                              child: AutoSizeText(
                                doctorModel.doctor.doctorStatus == "closed"
                                    ? "مغلق الان".i18n
                                    : "مفتوح الان".i18n,
                                minFontSize: 11,
                                style: blueButton_14pt,
                              ),
                            ),
                          ),
                        )
                      : Positioned(
                          top: getProportionateScreenHeight(290),
                          right: getProportionateScreenWidth(10),
                          child: Container(
                            width: getProportionateScreenWidth(102),
                            height: getProportionateScreenHeight(40),
                            // padding: EdgeInsets.only(top: getProportionateScreenHeight(10),bottom: getProportionateScreenHeight(10),left: getProportionateScreenWidth(15),right:getProportionateScreenWidth(25) ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.white.withOpacity(0.5),
                                Colors.white.withOpacity(0.1),
                              ]),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(12)),
                            ),
                            child: Center(
                              child: AutoSizeText(
                                doctorModel.doctor.doctorStatus == "closed"
                                    ? "مغلق الان".i18n
                                    : "مفتوح الان".i18n,
                                minFontSize: 11,
                                style: blueButton_14pt,
                              ),
                            ),
                          ),
                        ),
                  appLocal == "ar"
                      ? Positioned(
                          top: getProportionateScreenHeight(260),
                          right: getProportionateScreenWidth(10),
                          // width: getProportionateScreenWidth(190),
                          height: getProportionateScreenHeight(80),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  // alignment: Alignment.centerRight,
                                  height: getProportionateScreenHeight(30),
                                  width: getProportionateScreenWidth(200),
                                  child: AutoSizeText(
                                    doctorModel.doctor.firstName +
                                        " " +
                                        doctorModel.doctor.lastName,
                                    // textDirection: TextDirection.rtl,
                                    style: blueButton_25pt,
                                  ),
                                ),
                                Container(
                                  height: getProportionateScreenHeight(20),
                                  // width: getProportionateScreenWidth(200),
                                  // alignment: Alignment.centerRight,
                                  // color: Colors.red,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.asset(
                                        "assets/images/home/location_icon.png",
                                        height:
                                            getProportionateScreenHeight(12),
                                      ),
                                      SizedBox(
                                        width: getProportionateScreenWidth(10),
                                      ),
                                      Container(
                                        // alignment: Alignment.centerRight,
                                        height:
                                            getProportionateScreenHeight(20),
                                        width: getProportionateScreenWidth(200),
                                        child: AutoSizeText(
                                          doctorModel.doctor.address,
                                          style: blueButton_14pt,
                                          minFontSize: 10,
                                          maxLines: 1,
                                          // textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/images/home/clock_icon.png",
                                      height: getProportionateScreenHeight(12),
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(10),
                                    ),
                                    Container(
                                      height: getProportionateScreenHeight(20),
                                      width: getProportionateScreenWidth(200),
                                      child: AutoSizeText(
                                        doctorModel.doctor.info,
                                        style: blueButton_14pt,
                                        minFontSize: 10,
                                        maxLines: 1,
                                        // textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : Positioned(
                          top: getProportionateScreenHeight(260),
                          left: getProportionateScreenWidth(10),
                          // width: getProportionateScreenWidth(190),
                          height: getProportionateScreenHeight(80),
                          child: Container(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Container(
                                  // alignment: Alignment.centerRight,
                                  height: getProportionateScreenHeight(30),
                                  width: getProportionateScreenWidth(250),
                                  // color: Colors.red,
                                  child: AutoSizeText(
                                    doctorModel.doctor.firstName +
                                        " " +
                                        doctorModel.doctor.lastName,
                                    // textDirection: TextDirection.rtl,
                                    style: blueButton_25pt,
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(5),
                                ),
                                Container(
                                  height: getProportionateScreenHeight(20),
                                  width: getProportionateScreenWidth(250),
                                  // alignment: Alignment.centerRight,
                                  // color: Colors.red,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.asset(
                                        "assets/images/home/location_icon.png",
                                        height:
                                            getProportionateScreenHeight(12),
                                      ),
                                      SizedBox(
                                        width: getProportionateScreenWidth(10),
                                      ),
                                      Container(
                                        // alignment: Alignment.centerRight,
                                        height:
                                            getProportionateScreenHeight(20),
                                        width: getProportionateScreenWidth(200),
                                        child: AutoSizeText(
                                          doctorModel.doctor.address,
                                          style: blueButton_14pt,
                                          minFontSize: 10,
                                          maxLines: 1,
                                          // textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(5),
                                ),
                                Container(
                                  height: getProportionateScreenHeight(20),
                                  width: getProportionateScreenWidth(250),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Image.asset(
                                      //   "assets/images/home/clock_icon.png",
                                      //   height: getProportionateScreenHeight(12),
                                      // ),
                                      Icon(
                                        Icons.info,
                                        color: Colors.grey,
                                        size: getProportionateScreenHeight(14),
                                      ),
                                      SizedBox(
                                        width: getProportionateScreenWidth(10),
                                      ),
                                      Container(
                                        height:
                                            getProportionateScreenHeight(20),
                                        width: getProportionateScreenWidth(200),
                                        child: AutoSizeText(
                                          doctorModel.doctor.info,
                                          style: blueButton_14pt,
                                          minFontSize: 10,
                                          maxLines: 1,
                                          // textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  Positioned(
                    top: getProportionateScreenHeight(350),
                    left: 0,
                    right: 0,
                    child: Container(
                      height: getProportionateScreenHeight(55),
                      child: Row(
                        children: [
                          Expanded(
                            child: GetBuilder<
                                CustomerDoctorDetailsLabelController>(
                              // init: _customerLabelController,
                              builder: (controller) => GestureDetector(
                                onTap: () {
                                  _tabController.animateTo(0);
                                  controller.changeIndex(0);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: getProportionateScreenHeight(12)),
                                  decoration: BoxDecoration(
                                    borderRadius: appLocal == "ar"
                                        ? BorderRadius.only(
                                            topRight: Radius.circular(12))
                                        : BorderRadius.only(
                                            topLeft: Radius.circular(12)),
                                    color: controller.backgroundColors[0],
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height:
                                            getProportionateScreenHeight(18),
                                        width: getProportionateScreenWidth(18),
                                        child: Image.asset(
                                          controller.services,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height:
                                            getProportionateScreenHeight(20),
                                        width: getProportionateScreenWidth(80),
                                        child: AutoSizeText(
                                          "الخدمات ".i18n,
                                          style: controller.servicesStyle,
                                          minFontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          ///products

                          Expanded(
                            child: GetBuilder<
                                CustomerDoctorDetailsLabelController>(
                              // init: _customerLabelController,
                              builder: (controller) => GestureDetector(
                                onTap: () {
                                  _tabController.animateTo(1);
                                  controller.changeIndex(1);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: getProportionateScreenHeight(12)),
                                  decoration: BoxDecoration(
                                    borderRadius: appLocal == "ar"
                                        ? BorderRadius.only(
                                            topLeft: Radius.circular(12))
                                        : BorderRadius.only(
                                            topRight: Radius.circular(12)),
                                    color: controller.backgroundColors[1],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height:
                                            getProportionateScreenHeight(18),
                                        width: getProportionateScreenWidth(18),
                                        child: Image.asset(
                                          controller.personalInfo,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height:
                                            getProportionateScreenHeight(20),
                                        width: getProportionateScreenWidth(80),
                                        child: AutoSizeText(
                                          "معلومات شخصية ".i18n,
                                          style: controller.personalInfoStyle,
                                          minFontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          ///about store

                          // Expanded(
                          //   child: GetBuilder<CustomerDoctorDetailsLabelController>(
                          //     init: _customerDoctorDetailsLabelController,
                          //     builder: (controller) => GestureDetector(
                          //       onTap: () {
                          //         _tabController.animateTo(2);
                          //         controller.changeIndex(2);
                          //       },
                          //       child: Container(
                          //         padding: EdgeInsets.only(
                          //             top: getProportionateScreenHeight(12)),
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.only(topLeft: Radius.circular(12)),
                          //           color: controller.backgroundColors[2],
                          //         ),
                          //         child: Column(
                          //           crossAxisAlignment: CrossAxisAlignment.center,
                          //           children: [
                          //             Container(
                          //               height: getProportionateScreenHeight(18),
                          //               width: getProportionateScreenWidth(18),
                          //               child: Image.asset(
                          //                 controller.ordersResponse,
                          //                 fit: BoxFit.fill,
                          //               ),
                          //             ),
                          //             Container(
                          //               alignment: Alignment.center,
                          //               height: getProportionateScreenHeight(20),
                          //               width: getProportionateScreenWidth(80),
                          //               child: AutoSizeText(
                          //                 "ردود الطلبات",
                          //                 style: controller.ordersResponseStyle,
                          //                 minFontSize: 8,
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          ///orders
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: getProportionateScreenHeight(405),
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          DoctorServicesBody(doctorModel.doctor.doctorServices),
                          DoctorPersonalInfoBody(doctorModel.doctor),
                          // DoctorOrdersResponseBody(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
