import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pets/configuration/constants/api.dart';
import 'package:pets/configuration/constants/colors.dart';
import 'package:pets/configuration/constants/text_style.dart';
import 'package:pets/configuration/size_config.dart';
import 'package:pets/main.dart';
import 'package:pets/screens/corner/model/corner_model.dart';
import 'package:pets/screens/corner/view/corner_details.dart';
import 'package:pets/screens/doctors/view/doctor_details.dart';
import 'package:pets/screens/home/view/components/favorite_icon.dart';
import 'package:pets/screens/home/view/components/open_now_coponent.dart';
import 'package:pets/screens/home/view/components/social_media_components.dart';
import 'package:get/get.dart';
import 'package:pets/screens/stores/view/store_details.dart';

import '../my_corner_details.dart';
import 'translations/my_cornar_card.i18n.dart';

class MyCornerVerticalCard extends StatelessWidget {
  Corner corner;

  MyCornerVerticalCard(this.corner, this.delete);

  Function delete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(MyCornerDetails(corner));
      },
      child: Container(
        height: getProportionateScreenHeight(135),
        width: getProportionateScreenWidth(390),
        margin: EdgeInsets.only(
            left: getProportionateScreenWidth(24),
            right: getProportionateScreenWidth(24),
            bottom: getProportionateScreenHeight(25)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 0.3, color: borderColor),
          boxShadow: shadow,
          color: backgroundGrey,
        ),
        child: Stack(
          children: [
            appLocal == "ar"
                ? Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      height: getProportionateScreenHeight(134),
                      width: getProportionateScreenWidth(154),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        // color: Colors.red
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12)),
                        child: Image.network(
                          Api.imagePath + corner.image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  )
                : Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      height: getProportionateScreenHeight(134),
                      width: getProportionateScreenWidth(154),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12)),
                        // color: Colors.red
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12)),
                        child: Image.network(
                          Api.imagePath + corner.image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),

            ///image

            appLocal == "ar"
                ? Positioned(
                    right: getProportionateScreenWidth(171),
                    top: getProportionateScreenHeight(20),
                    bottom: getProportionateScreenHeight(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: getProportionateScreenHeight(30),
                          width: getProportionateScreenWidth(150),
                          child: AutoSizeText(
                            corner.name,
                            // textDirection: TextDirection.rtl,
                            style: body3_18pt,
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(5),
                        ),
                        Container(
                          height: getProportionateScreenHeight(20),
                          width: getProportionateScreenWidth(150),
                          child: AutoSizeText(
                            corner.userName != ""
                                ? corner.userName
                                : corner.doctorName != ""
                                    ? corner.doctorName
                                    : corner.storeName != ""
                                        ? corner.storeName
                                        : "",
                            // textDirection: TextDirection.rtl,
                            style: darkBlueText_11pt,
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(5),
                        ),
                        Container(
                          height: getProportionateScreenHeight(42),
                          width: getProportionateScreenWidth(150),
                          child: AutoSizeText(
                            corner.desc,
                            // textDirection: TextDirection.rtl,
                            style: darkGrayText_11pt,
                          ),
                        ),
                      ],
                    ),
                  )
                : Positioned(
                    left: getProportionateScreenWidth(171),
                    top: getProportionateScreenHeight(20),
                    bottom: getProportionateScreenHeight(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: getProportionateScreenHeight(30),
                          width: getProportionateScreenWidth(150),
                          child: AutoSizeText(
                            corner.name,
                            // textDirection: TextDirection.rtl,
                            style: body3_18pt,
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(5),
                        ),
                        Container(
                          height: getProportionateScreenHeight(20),
                          width: getProportionateScreenWidth(150),
                          child: AutoSizeText(
                            corner.userName != ""
                                ? corner.userName
                                : corner.doctorName != ""
                                    ? corner.doctorName
                                    : corner.storeName != ""
                                        ? corner.storeName
                                        : "",
                            // textDirection: TextDirection.rtl,
                            style: darkBlueText_11pt,
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(5),
                        ),
                        Container(
                          height: getProportionateScreenHeight(42),
                          width: getProportionateScreenWidth(150),
                          child: AutoSizeText(
                            corner.desc,
                            // textDirection: TextDirection.rtl,
                            style: darkGrayText_11pt,
                          ),
                        ),
                      ],
                    ),
                  ),

            appLocal == "ar"
                ? Positioned(
                    left: getProportionateScreenWidth(8),
                    top: getProportionateScreenHeight(8),
                    child: Container(
                        height: getProportionateScreenHeight(35),
                        width: getProportionateScreenWidth(35),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: ((context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        title: Text(
                                          'هل أنت متأكد ؟'.i18n,
                                          // textDirection: TextDirection.rtl,
                                          style: body3_18pt,
                                        ),
                                        content: Text(
                                          'انت على وشك حذف هذه الزاوية !'.i18n,
                                          // textDirection: TextDirection.rtl,
                                          style: body1_16pt,
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text(
                                              'نعم'.i18n,
                                            ),
                                            onPressed: () async {
                                              // language.changeLanguage();
                                              Navigator.of(context).pop();
                                              await delete();
                                              // Navigator.popUntil(context, ModalRoute.withName('/'));
                                            },
                                          ),
                                          TextButton(
                                            child: Text('لا'.i18n),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      )));
                            },
                            child: Image.asset(
                              "assets/images/vendor_app/trash.png",
                              fit: BoxFit.fill,
                            ))))
                : Positioned(
                    right: getProportionateScreenWidth(8),
                    top: getProportionateScreenHeight(8),
                    child: Container(
                        height: getProportionateScreenHeight(35),
                        width: getProportionateScreenWidth(35),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: ((context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        title: Text(
                                          'هل أنت متأكد ؟'.i18n,
                                          // textDirection: TextDirection.rtl,
                                          style: body3_18pt,
                                        ),
                                        content: Text(
                                          'انت على وشك حذف هذه الزاوية !'.i18n,
                                          // textDirection: TextDirection.rtl,
                                          style: body1_16pt,
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text(
                                              'نعم'.i18n,
                                            ),
                                            onPressed: () async {
                                              // language.changeLanguage();
                                              Navigator.of(context).pop();
                                              await delete();
                                              // Navigator.popUntil(context, ModalRoute.withName('/'));
                                            },
                                          ),
                                          TextButton(
                                            child: Text('لا'.i18n),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      )));
                            },
                            child: Image.asset(
                              "assets/images/vendor_app/trash.png",
                              fit: BoxFit.fill,
                            ))))
          ],
        ),
      ),
    );
  }
}
