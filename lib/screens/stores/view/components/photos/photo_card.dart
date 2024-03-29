import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pets/configuration/constants/api.dart';
import 'package:pets/configuration/constants/colors.dart';
import 'package:pets/configuration/constants/text_style.dart';
import 'package:pets/configuration/size_config.dart';
import '../../../../vendor_app/model/product.dart';
import 'package:pets/screens/vendor_app/model/image_model.dart' as im;

class StoreImageCard extends StatelessWidget {
  StoreImageCard(this.image);

  im.Image image;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: getProportionateScreenWidth(16),right:getProportionateScreenWidth(16),bottom: getProportionateScreenHeight(16)),
      width: getProportionateScreenWidth(163),
      height: getProportionateScreenHeight(160),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 0.3, color: borderColor),
          color: Colors.white),
      child: Stack(
        children: [
          // Positioned(
          //     top: getProportionateScreenHeight(120),
          //     child: Container(
          //       padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
          //       height: getProportionateScreenHeight(40),
          //       width: getProportionateScreenWidth(162.7),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.only(
          //           bottomRight: Radius.circular(12),
          //           bottomLeft: Radius.circular(12),
          //         ),
          //         color: Colors.grey.shade200,
          //       ),
          //       child: AutoSizeText(
          //         storeProdcut.name,
          //         textAlign: TextAlign.center,
          //         style: body2_14pt,
          //         minFontSize: 9,
          //       ),
          //     )),
          Positioned(
              left: 0,
              top: 0,
              child: Container(
                height: getProportionateScreenHeight(160),
                width: getProportionateScreenWidth(162.7),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  child: Image.network(
                    Api.imagePath + image.path,
                    fit: BoxFit.fill,
                  ),
                ),

                // Image.asset(
                //   "assets/images/home/cat_1.png",
                //   fit: BoxFit.fill,
                // ),
              )),

          // Positioned(
          //     left: getProportionateScreenWidth(25),
          //     top: getProportionateScreenHeight(8),
          //     child: Container(
          //       height: getProportionateScreenHeight(14),
          //       width: getProportionateScreenWidth(15),
          //       child: IconButton(
          //         icon: Icon(
          //           CupertinoIcons.heart,
          //           size: 22,
          //         ),
          //       ),
          //     ))
        ],
      ),
    );
  }
}
