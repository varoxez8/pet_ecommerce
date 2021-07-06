import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_ecommerce/screens/vendor_app/view/components/products/vendor_products_body.dart';
import 'package:pets_ecommerce/configuration/size_config.dart';
import 'package:pets_ecommerce/screens/vendor_app/controller/vendor_label_controller.dart';
import 'package:pets_ecommerce/screens/vendor_app/model/constants.dart';
import 'package:pets_ecommerce/screens/widgets/floating_action_button.dart';

import 'components/about/about_store_body.dart';
import 'components/offers/vendor_offers_body.dart';
import 'components/orders/orders_body.dart';


class VendorDetailsPage extends StatefulWidget {
  @override
  _VendorDetailsPageState createState() => _VendorDetailsPageState();
}

class _VendorDetailsPageState extends State<VendorDetailsPage>
    with SingleTickerProviderStateMixin {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vendorAppTabController = TabController(length: 5, vsync: this);
    vendorAppTabController.addListener(() {
      vendorAppLabelController.changeIndex(vendorAppTabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      floatingActionButton: FancyFab(onPressed1:    (){

        vendorAppTabController.animateTo(0);
        vendorAppLabelController.changeIndex(0);
        vendorProductsController.changeToAddProduct();

      },
        onPressed2:  (){
          vendorAppTabController.animateTo(2);
          vendorAppLabelController.changeIndex(2);
          vendorOfferController.changeToAddOffer();
        },
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: getProportionateScreenHeight(300),
                child: Container(
                  child: Image.asset(
                    "assets/images/home/shop_image.png",
                    fit: BoxFit.fill,
                  ),
                ),
            ),

            Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: getProportionateScreenHeight(300),
                child: Container(
                  child: Image.asset(
                    "assets/images/store/black_layer.png",
                    fit: BoxFit.fill,
                  ),
                ),
            ),


            Positioned(
              top: getProportionateScreenHeight(34),
              left: getProportionateScreenWidth(24),
              child: GestureDetector(
                onTap: (){
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
            Positioned(
              top: getProportionateScreenHeight(180),
              right: getProportionateScreenWidth(10),
              child: Stack(
                children: [

                  Image.asset("assets/images/vendor_app/camera.png",    width: getProportionateScreenWidth(52),
                    height: getProportionateScreenHeight(52),fit: BoxFit.fill,),

                ],
              ),
            ),///camera

            Positioned(
              top: getProportionateScreenHeight(250),
              left: 0,
              right: 0,
              child: Container(
                height: getProportionateScreenHeight(55),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(

                    children: [
                      Expanded(
                        child: GetBuilder<VendorLabelController>(
                          init:  vendorAppLabelController,
                          builder: (controller) => GestureDetector(
                            onTap: () {
                              vendorAppTabController.animateTo(0);
                              controller.changeIndex(0);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: getProportionateScreenHeight(12)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12)),
                                color: controller.backgroundColors[0],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: getProportionateScreenHeight(18),
                                    width: getProportionateScreenWidth(18),
                                    child: Image.asset(
                                      controller.product,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: getProportionateScreenHeight(20),
                                    width: getProportionateScreenWidth(80),
                                    child: AutoSizeText(
                                      "المنتجات",
                                      style: controller.productsStyle,
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
                        child: GetBuilder<VendorLabelController>(
                          init:  vendorAppLabelController,
                          builder: (controller) => GestureDetector(
                            onTap: () {
                              vendorAppTabController.animateTo(1);
                              controller.changeIndex(1);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: getProportionateScreenHeight(12)),
                              decoration: BoxDecoration(
                                color: controller.backgroundColors[1],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: getProportionateScreenHeight(18),
                                    width: getProportionateScreenWidth(18),
                                    child: Image.asset(
                                      controller.aboutStore,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: getProportionateScreenHeight(20),
                                    width: getProportionateScreenWidth(80),
                                    child: AutoSizeText(
                                      "عن المتجر",
                                      style: controller.aboutStoreStyle,
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

                      Expanded(
                        child: GetBuilder<VendorLabelController>(
                          init:  vendorAppLabelController,
                          builder: (controller) => GestureDetector(
                            onTap: () {
                              vendorAppTabController.animateTo(2);
                              controller.changeIndex(2);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: getProportionateScreenHeight(12)),
                              decoration: BoxDecoration(
                                color: controller.backgroundColors[2],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: getProportionateScreenHeight(18),
                                    width: getProportionateScreenWidth(18),
                                    child: Image.asset(
                                      controller.offers,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: getProportionateScreenHeight(20),
                                    width: getProportionateScreenWidth(80),
                                    child: AutoSizeText(
                                      "العروض",
                                      style: controller.offersStyle,
                                      minFontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      ///offers
                Expanded(
                        child: GetBuilder<VendorLabelController>(
                          init:  vendorAppLabelController,
                          builder: (controller) => GestureDetector(
                            onTap: () {
                              vendorAppTabController.animateTo(3);
                              controller.changeIndex(3);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: getProportionateScreenHeight(12)),
                              decoration: BoxDecoration(
                                color: controller.backgroundColors[3],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: getProportionateScreenHeight(18),
                                    width: getProportionateScreenWidth(18),
                                    child: Image.asset(
                                      controller.orders,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: getProportionateScreenHeight(20),
                                    width: getProportionateScreenWidth(80),
                                    child: AutoSizeText(
                                      "ردود الطلبات",
                                      style: controller.ordersStyle,
                                      minFontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      ///orders

                      Expanded(
                        child: GetBuilder<VendorLabelController>(
                          init:  vendorAppLabelController,
                          builder: (controller) => GestureDetector(
                            onTap: () {
                              vendorAppTabController.animateTo(4);
                              controller.changeIndex(4);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: getProportionateScreenHeight(12)),
                              // padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(5)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12)),
                                color: controller.backgroundColors[4],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: getProportionateScreenHeight(18),
                                    width: getProportionateScreenWidth(18),
                                    child: Image.asset(
                                      controller.photos,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: getProportionateScreenHeight(20),
                                    width: getProportionateScreenWidth(80),
                                    child: AutoSizeText(
                                      "الصور",
                                      style: controller.photosStyle,
                                      minFontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      ///photos
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: getProportionateScreenHeight(305),
                left: 0,
                right: 0,
                bottom: 0,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    child: TabBarView(
                      controller: vendorAppTabController,
                      children: [
                        // ProductsBodyScreen(),
                        // AboutStoreBodyScreen(),
                        // OffersBodyScreen(),
                        // OrdersBodyScreen(),
                        VendorProductsBodyScreen(),
                        AboutStoreBodyScreen(),
                        VendorOffersBodyScreen(),
                        OrdersBodyScreen(),
                        OrdersBodyScreen()
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}