import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pets_ecommerce/configuration/constants/colors.dart';
import 'package:pets_ecommerce/configuration/constants/text_style.dart';
import 'package:pets_ecommerce/configuration/size_config.dart';
import 'package:pets_ecommerce/screens/doctors/view/doctor_details.dart';
import 'package:pets_ecommerce/screens/home/view/components/favorite_icon.dart';
import 'package:pets_ecommerce/screens/home/view/components/open_now_coponent.dart';
import 'package:pets_ecommerce/screens/home/view/components/social_media_components.dart';
import 'package:get/get.dart';
import 'package:pets_ecommerce/screens/stores/view/store_details.dart';

import '../corner_details.dart';

class VerticalCornerListCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(CornerDetails());
      },
      child: Container(
        height: getProportionateScreenHeight(135),
        width: getProportionateScreenWidth(345),
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
            Positioned(
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
                  child: Image.asset(
                    "assets/images/home/shop_image.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),

            ///image

            Positioned(
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
                      "عنوان الزاوية",
                      textDirection: TextDirection.rtl,
                      style: body3_18pt,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(5),),

   Container(
                    height: getProportionateScreenHeight(20),
                    width: getProportionateScreenWidth(150),
                    child: AutoSizeText(
                      "اسم المستخدم",
                      textDirection: TextDirection.rtl,
                      style: darkBlueText_11pt,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(5),),
                  Container(
                    height: getProportionateScreenHeight(42),
                    width: getProportionateScreenWidth(150),
                    child: AutoSizeText(
                   "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة،  ",
                      textDirection: TextDirection.rtl,
                      style: darkGrayText_11pt,
                    ),
                  ),



                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}