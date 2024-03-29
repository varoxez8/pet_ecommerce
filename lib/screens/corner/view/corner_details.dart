import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pets/configuration/constants/api.dart';
import 'package:pets/configuration/constants/colors.dart';
import 'package:pets/configuration/constants/text_style.dart';
import 'package:pets/configuration/printer.dart';
import 'package:pets/configuration/size_config.dart';
import 'package:pets/main.dart';
import 'package:pets/screens/auth/controller/services/auth_services.dart';
import 'package:pets/screens/auth/model/user.dart';
import 'package:pets/screens/categories/view/catgory_stores.dart';
import 'package:pets/screens/corner/model/corner_model.dart';
import 'package:http/http.dart' as http;
import 'package:pets/services/http_requests_service.dart';

import '../../loading_screen.dart';
import 'package:get/get.dart';
import 'package:pets/screens/my_corner/view/components/corner_images_view.dart';
import 'translations/corner_details.i18n.dart';

class CornerDetails extends StatefulWidget {
  bool end;
  Corner corner;

  CornerDetails(this.corner, this.end);

  @override
  _CornerDetailsState createState() => _CornerDetailsState();
}

class _CornerDetailsState extends State<CornerDetails> {
  bool loading = false;
  bool error = false;
  CornersModel cornersModel;

  fetchData() async {
    consolePrint(widget.corner.userId.toString());
    consolePrint(widget.corner.storeId.toString());
    consolePrint("fetch data");
    loading = true;
    setState(() {});
    try {
      // UserModel userModel= await AuthServices.getCurrentUser();
      consolePrint("before corners requests");
      var url;
      if (widget.corner.storeId != -1) {
        url = Uri.parse(
          "${Api.baseUrl}/corners?store_id=${widget.corner.storeId}",
        );
      } else {
        url = Uri.parse(
          "${Api.baseUrl}/corners?doctor_id=${widget.corner.userId}",
        );
      }
      consolePrint("try to get from $url");
      final apiResult =
          await http.get(url, headers: await HttpService().getHeaders());
      consolePrint("corners statusCode" + apiResult.statusCode.toString());
      consolePrint("corners body" + apiResult.body.toString());
      if (apiResult.statusCode == 200) {
        cornersModel = cornersModelFromJson(apiResult.body);
        consolePrint(cornersModel.toString());
      } else {
        error = true;
      }
      loading = false;
      setState(() {});
    } catch (e) {
      loading = false;
      error = true;
      setState(() {});
      consolePrint("Corners error:" + e.toString());
    }
    consolePrint("after corners requests");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    consolePrint("in int state");
    if (!widget.end) fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: error
            ? ErrorScreen()
            : loading
                ? LoadingScreen()
                : Stack(
                    children: [
                      Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          height: getProportionateScreenHeight(270),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: shadow,
                            ),
                            child: Image.network(
                              Api.imagePath + widget.corner.image,
                              fit: BoxFit.fill,
                            ),
                          )),
                      Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          height: getProportionateScreenHeight(270),
                          child: Container(
                            child: Image.asset(
                              "assets/images/store/black_layer.png",
                              fit: BoxFit.fill,
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
                                color: Colors.white.withOpacity(0.8),
                                shape: BoxShape.circle),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios_outlined,
                                size: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      appLocal == "ar"
                          ? Positioned(
                              top: getProportionateScreenHeight(190),
                              right: getProportionateScreenWidth(15),
                              height: getProportionateScreenHeight(35),
                              child: Container(
                                height: getProportionateScreenHeight(35),
                                // width: getProportionateScreenWidth(150),

                                child: AutoSizeText(
                                  widget.corner.userName != ""
                                      ? widget.corner.userName
                                      : widget.corner.doctorName != ""
                                          ? widget.corner.doctorName
                                          : widget.corner.storeName != ""
                                              ? widget.corner.storeName
                                              : "",
                                  style: blueButton_25pt,
                                  // textDirection: TextDirection.rtl,
                                ),
                              ))
                          : Positioned(
                              top: getProportionateScreenHeight(190),
                              left: getProportionateScreenWidth(15),
                              height: getProportionateScreenHeight(35),
                              child: Container(
                                height: getProportionateScreenHeight(35),
                                // width: getProportionateScreenWidth(150),

                                child: AutoSizeText(
                                  widget.corner.userName != ""
                                      ? widget.corner.userName
                                      : widget.corner.doctorName != ""
                                          ? widget.corner.doctorName
                                          : widget.corner.storeName != ""
                                              ? widget.corner.storeName
                                              : "",
                                  style: blueButton_25pt,
                                  // textDirection: TextDirection.rtl,
                                ),
                              )),
                      Positioned(
                          top: getProportionateScreenHeight(305),
                          right: getProportionateScreenWidth(15),
                          height: getProportionateScreenHeight(505),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: getProportionateScreenHeight(35),
                                  width: getProportionateScreenWidth(345),
                                  child: AutoSizeText(
                                    widget.corner.name,
                                    // textDirection: TextDirection.rtl,
                                    style: h6_20pt,
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(20),
                                ),
                                Container(
                                  width: getProportionateScreenWidth(345),
                                  // alignment: Alignment.centerRight,
                                  child: AutoSizeText(
                                    widget.corner.desc,
                                    // textDirection: TextDirection.rtl,
                                    style: darkGrayText_16pt,
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(50),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 130,
                                  width: getProportionateScreenWidth(340),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget.corner.images.length,
                                    itemBuilder: (context, index) => Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                getProportionateScreenWidth(5)),
                                        child: GestureDetector(
                                            onTap: () {
                                              Get.to(() => CornerPhotosView(
                                                  widget.corner.images, index));
                                            },
                                            child: Container(
                                              width:
                                                  getProportionateScreenWidth(
                                                      105),
                                              decoration: BoxDecoration(
                                                  boxShadow: shadow),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.network(
                                                    Api.imagePath +
                                                        widget.corner
                                                            .images[index].path,
                                                    fit: BoxFit.fill,
                                                  )),
                                            ))),
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(20),
                                ),
                                widget.end || cornersModel.corners.length == 0
                                    ? Container(
                                        width: 0,
                                        height: 0,
                                      )
                                    : Column(
                                        children: [
                                          Container(
                                            height:
                                                getProportionateScreenHeight(
                                                    35),
                                            width: getProportionateScreenWidth(
                                                345),
                                            child: AutoSizeText(
                                              "الزوايا السابقة".i18n,
                                              // textDirection: TextDirection.rtl,
                                              style: h6_20pt,
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    20),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            height: 130,
                                            width: getProportionateScreenWidth(
                                                340),
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  cornersModel.corners.length,
                                              itemBuilder: (context, index) => cornersModel
                                                          .corners[index].id !=
                                                      widget.corner.id
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        consolePrint(
                                                            "pressed !!!!!!");
                                                        consolePrint(
                                                            "inside button !!!!!!");
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    CornerDetails(
                                                                        cornersModel
                                                                            .corners[index],
                                                                        true)));
                                                      },
                                                      child: Container(
                                                          width:
                                                              getProportionateScreenWidth(
                                                                  105),
                                                          child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          5),
                                                              child: Container(
                                                                width:
                                                                    getProportionateScreenWidth(
                                                                        103),
                                                                height:
                                                                    getProportionateScreenHeight(
                                                                        127),
                                                                child:
                                                                    ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8),
                                                                        child: Image
                                                                            .network(
                                                                          Api.imagePath +
                                                                              cornersModel.corners[index].image,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        )),
                                                              ))
                                                          // Image.network(cornersModel.corners[index].image,fit: BoxFit.fill,),
                                                          ))
                                                  : Container(
                                                      width: 0,
                                                      height: 0,
                                                    ),
                                            ),
                                          ),
                                          // SizedBox(height: getProportionateScreenHeight(10),),
                                        ],
                                      ),
                              ],
                            ),
                          )),
                    ],
                  ),
      ),
    );
  }
}
