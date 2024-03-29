import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pets/configuration/constants/api.dart';
import 'package:pets/configuration/constants/gradient.dart';
import 'package:pets/configuration/constants/text_style.dart';
import 'package:pets/configuration/size_config.dart';
import 'package:pets/screens/auth/view/register/register_screen.dart';
import 'package:pets/screens/doctor_app/controller/doctor_controler.dart';
import 'package:pets/screens/doctor_app/requests/doctor_info_requests.dart';
import 'package:pets/screens/vendor_app/controller/products_controller.dart';
import 'package:pets/screens/vendor_app/model/categories.dart';
import 'package:pets/screens/vendor_app/model/constants.dart';
import 'package:pets/screens/vendor_app/model/product.dart';
import 'package:pets/screens/vendor_app/model/types.dart';
import 'package:pets/screens/vendor_app/requests/products_requests.dart';
import 'package:pets/screens/widgets/text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math' as Math;
import 'package:image/image.dart' as Im;
import 'dart:io';
import 'package:get/get.dart';
import '../../../../../main.dart';
import 'translations/add_new_service_screen.i18n.dart';

class VendorAppAddService extends StatefulWidget {
  @override
  _VendorAppAddServiceState createState() => _VendorAppAddServiceState();
  DoctorController doctorController;

  VendorAppAddService(this.doctorController);
}

class _VendorAppAddServiceState extends State<VendorAppAddService> {
  String categoryName = "";
  int categoryId;
  var pen = false.obs;
  List<Category> vendor_category_items = [];
  var image;

  File tmpFile;
  String base64Image;
  String newImage = "";

  getcompress(File imageFile) async {
    setState(() {
      isloading = true;
    });
    newImage = await compressImage(imageFile);
    setState(() {
      isloading = false;
    });
  }

  bool changeImage = false;

  Future<String> compressImage(File f) async {
    isloading = true;
    setState(() {});
    print('starting compression');
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = new Math.Random().nextInt(10000);
    print('before decoding img');
    Im.Image image = Im.decodeImage(f.readAsBytesSync());
    print('before decoding img2');
    image = Im.copyResize(image,
        width: 1080); //MediaQuery.of(context).size.width.toInt());

    // image.format = Im.Image.RGBA; //was in old version of flutter
    //Im.Image newim = Im.remapColors(image, alpha: Im.LUMINANCE);
    // image = Im.remapColors(image, alpha: Im.LUMINANCE);
    print('before reducing quality');
    var newim2 = new File('$path/$rand.jpg')
      ..writeAsBytesSync(Im.encodeJpg(image, quality: 50));

    setState(() {
      tmpFile = newim2;
      base64Image = base64Encode(tmpFile.readAsBytesSync());
      isloading = false;
    });

    String fileName = tmpFile.path.split('/').last;

    //await upload(fileName);
    print('done');
    return base64Image;
  }

  bool isloading = false;
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  DoctorAppRequests doctorAppRequests = DoctorAppRequests();

  fetchdata() async {
    setState(() {
      isloading = true;
    });

    vendor_category_items = await doctorAppRequests.getStoreCategories();
    categoryName = vendor_category_items[0].name;
    categoryId = vendor_category_items[0].id;
    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Material(
                    elevation: 5,
                    color: Colors.white,
                    child: Container(
                        width: SizeConfig.screenWidth,
                        height: getProportionateScreenHeight(95),
                        child: Row(
                          children: [
                            SizedBox(
                              width: getProportionateScreenWidth(24),
                            ),
                            Spacer(),
                            Container(
                                height: getProportionateScreenHeight(28),
                                child: AutoSizeText(
                                  "اضافة خدمة جديد".i18n,
                                  style: h5_21pt,
                                  minFontSize: 8,
                                )),
                            Spacer(),
                            SizedBox(
                              width: getProportionateScreenWidth(24),
                            ),
                          ],
                        )),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(40),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(16)),
                  child: Column(
                    children: [
                      GetBuilder<DoctorController>(
                        init: widget.doctorController,
                        builder: (controller) => controller.isLoading == true ||
                                isloading == true
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: getProportionateScreenHeight(50),
                                    width: getProportionateScreenWidth(50),
                                    child: CircularProgressIndicator(),
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  Container(
                                    height: getProportionateScreenHeight(30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width:
                                              getProportionateScreenWidth(180),
                                          height:
                                              getProportionateScreenHeight(30),
                                          child: AutoSizeText(
                                            "اضف خدمة جديد".i18n,
                                            style: h5_21pt,
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              descriptionController.text = "";
                                              priceController.text = "";
                                              nameController.text = "";
                                              categoryName =
                                                  vendor_category_items[0].name;
                                              categoryId =
                                                  vendor_category_items[0].id;
                                              image = null;
                                              pen.value = false;
                                              setState(() {});
                                            },
                                            child: Container(
                                              width:
                                                  getProportionateScreenWidth(
                                                      100),
                                              height:
                                                  getProportionateScreenHeight(
                                                      60),
                                              child: AutoSizeText(
                                                "إعادة ضبط".i18n,
                                                style: body2_14pt_underlined,
                                                maxLines: 1,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(25),
                                  ),
                                  Container(
                                    height: getProportionateScreenHeight(30),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                          height:
                                              getProportionateScreenHeight(30),
                                          alignment: appLocal == "ar"
                                              ? Alignment.bottomRight
                                              : Alignment.bottomLeft,
                                          child: AutoSizeText(
                                            "الصنف".i18n,
                                            style: body3_18pt,
                                          ),
                                        )),
                                        Expanded(
                                            child: Container(
                                          height:
                                              getProportionateScreenHeight(30),
                                          alignment: appLocal == "ar"
                                              ? Alignment.bottomRight
                                              : Alignment.bottomLeft,
                                          child: AutoSizeText(
                                            "السعر".i18n,
                                            style: body3_18pt,
                                          ),
                                        )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(20),
                                  ),
                                  Container(
                                    height: getProportionateScreenHeight(60),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: appLocal == "ar"
                                                ? Alignment.centerRight
                                                : Alignment.centerLeft,
                                            child: Container(
                                                width:
                                                    getProportionateScreenWidth(
                                                        156),
                                                height:
                                                    getProportionateScreenHeight(
                                                        45),
                                                padding: EdgeInsets.only(
                                                    right:
                                                        getProportionateScreenWidth(
                                                            4)),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.grey
                                                          .withOpacity(0.6)),
                                                ),
                                                // padding: EdgeInsets.symmetric(
                                                //     horizontal: 15),

                                                alignment: appLocal == "ar"
                                                    ? Alignment.centerRight
                                                    : Alignment.centerLeft,
                                                child: Directionality(
                                                  textDirection:
                                                      appLocal == "ar"
                                                          ? TextDirection.ltr
                                                          : TextDirection.rtl,
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton(
                                                      // value: controller.storeInfo.address,
                                                      // value: _value,
                                                      items:
                                                          vendor_category_items
                                                              .map((Category
                                                                  item) {
                                                        return DropdownMenuItem<
                                                            Category>(
                                                          value: item,
                                                          child: Container(
                                                            width:
                                                                getProportionateScreenWidth(
                                                                    135),
                                                            height:
                                                                getProportionateScreenHeight(
                                                                    30),
                                                            child: AutoSizeText(
                                                              item.name,

                                                              // textDirection:
                                                              // TextDirection.rtl,

                                                              style:
                                                                  blackText_14pt,
                                                              minFontSize: 8,
                                                              maxLines: 1,
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onChanged:
                                                          (category) async {
                                                        print("before");
                                                        setState(() {
                                                          categoryName =
                                                              category.name;
                                                          categoryId =
                                                              category.id;
                                                        });
                                                        print("after");
                                                      },
                                                      hint: Container(
                                                        width:
                                                            getProportionateScreenWidth(
                                                                110),
                                                        alignment:
                                                            appLocal == "ar"
                                                                ? Alignment
                                                                    .centerRight
                                                                : Alignment
                                                                    .centerLeft,
                                                        child: AutoSizeText(
                                                          categoryName,
                                                          maxLines: 1,
                                                          minFontSize: 9,
                                                        ),
                                                      ),
                                                      elevation: 8,
                                                      style: blackText_14pt,
                                                      icon: Container(
                                                          width:
                                                              getProportionateScreenWidth(
                                                                  8),
                                                          child: RotatedBox(
                                                              quarterTurns: 90,
                                                              child: Icon(Icons
                                                                  .arrow_drop_down))),
                                                      iconDisabledColor:
                                                          Colors.black,
                                                      iconEnabledColor:
                                                          Colors.blue,
                                                      // isExpanded: true,
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: appLocal == "ar"
                                                ? Alignment.centerRight
                                                : Alignment.centerLeft,
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  right:
                                                      getProportionateScreenWidth(
                                                          4)),
                                              width:
                                                  getProportionateScreenWidth(
                                                      156),
                                              height:
                                                  getProportionateScreenHeight(
                                                      45),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey
                                                        .withOpacity(0.6)),
                                              ),
                                              // padding: EdgeInsets.symmetric(
                                              //     horizontal: 15),
                                              child: CustomTextField(
                                                textEditingController:
                                                    priceController,
                                                // suffixImage: "assets/images/vendor_app/pen.png",
                                                textInputType:
                                                    TextInputType.number,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Container(
                                        //   alignment: Alignment.centerRight,
                                        //   child: Container(
                                        //       width: getProportionateScreenWidth(156),
                                        //       height: getProportionateScreenHeight(45),
                                        //       alignment: Alignment.centerRight,
                                        //       decoration: BoxDecoration(
                                        //         borderRadius: BorderRadius.circular(6),
                                        //         border: Border.all(
                                        //             width: 1, color: Colors.grey.withOpacity(0.6)),
                                        //       ),
                                        //       padding: EdgeInsets.symmetric(horizontal: 15),
                                        //       child: DropdownButtonHideUnderline(
                                        //         child: DropdownButton<String>(
                                        //           // value: type,
                                        //           items: .map((String item) {
                                        //             return DropdownMenuItem<String>(
                                        //               value: item,
                                        //               child: Text(item),
                                        //             );
                                        //           }).toList(),
                                        //           onChanged: (value) {
                                        //             setState(() {
                                        //               category = value;
                                        //             });
                                        //           },
                                        //           hint: Text(category),
                                        //           elevation: 8,
                                        //           style: blackText_14pt,
                                        //           icon: Icon(Icons.arrow_drop_down),
                                        //           iconDisabledColor: Colors.black,
                                        //           iconEnabledColor: Colors.blue.withOpacity(0.6),
                                        //           // isExpanded: true,
                                        //         ),
                                        //       )),
                                        // ),
                                        // Container(
                                        //   alignment: Alignment.centerRight,
                                        //   child: Container(
                                        //       width: getProportionateScreenWidth(156),
                                        //       height: getProportionateScreenHeight(45),
                                        //       alignment: Alignment.centerRight,
                                        //       decoration: BoxDecoration(
                                        //         borderRadius: BorderRadius.circular(6),
                                        //         border: Border.all(
                                        //             width: 1, color: Colors.grey.withOpacity(0.6)),
                                        //       ),
                                        //       padding: EdgeInsets.symmetric(horizontal: 15),
                                        //       child: DropdownButtonHideUnderline(
                                        //         child: DropdownButton<String>(
                                        //           // value: type,
                                        //           items: vendor_type_items.map((String item) {
                                        //             return DropdownMenuItem<String>(
                                        //               value: item,
                                        //               child: Text(item),
                                        //             );
                                        //           }).toList(),
                                        //           onChanged: (value) {
                                        //             setState(() {
                                        //               type = value;
                                        //             });
                                        //           },
                                        //           hint: Text(type),
                                        //           elevation: 8,
                                        //           style: blackText_14pt,
                                        //           icon: Icon(Icons.arrow_drop_down),
                                        //           iconDisabledColor: Colors.black,
                                        //           iconEnabledColor: Colors.blue.withOpacity(0.6),
                                        //           // isExpanded: true,
                                        //         ),
                                        //       )),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(25),
                                  ),
                                  Container(
                                    height: getProportionateScreenHeight(30),
                                    alignment: appLocal == "ar"
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: AutoSizeText(
                                      "اسم الخدمة".i18n,
                                      style: body3_18pt,
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(20),
                                  ),
                                  Container(
                                    height: getProportionateScreenHeight(65),
                                    width: SizeConfig.screenWidth,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.6),
                                            width: 1)),
                                    child: CustomTextField(
                                        textEditingController: nameController),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(25),
                                  ),
                                  Container(
                                    height: getProportionateScreenHeight(30),
                                    child: Container(
                                      alignment: appLocal == "ar"
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      height: getProportionateScreenHeight(30),
                                      // width: getProportionateScreenWidth(150),
                                      child: AutoSizeText(
                                        "صورة الخدمة".i18n,
                                        style: body3_18pt,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(20),
                                  ),
                                  Container(
                                    height: getProportionateScreenHeight(100),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.6),
                                            width: 1)),
                                    child: image == null
                                        ? GestureDetector(
                                            onTap: () async {
                                              image =
                                                  await ImagePicker.pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              File imageFile = File(image.path);
                                              if (image != null) {
                                                getcompress(imageFile);
                                              }
                                              setState(() {});
                                            },
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child: Image.asset(
                                                    "assets/images/vendor_app/upload_photo.png",
                                                    height:
                                                        getProportionateScreenHeight(
                                                            75),
                                                    width:
                                                        getProportionateScreenWidth(
                                                            125),
                                                  ),
                                                ),
                                                Center(
                                                    child: Container(
                                                  height:
                                                      getProportionateScreenHeight(
                                                          20),
                                                  width:
                                                      getProportionateScreenWidth(
                                                          80),
                                                  child: AutoSizeText(
                                                    "حمل الصورة".i18n,
                                                    style: body1_16pt,
                                                    maxLines: 1,
                                                  ),
                                                ))
                                              ],
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () async {
                                              image =
                                                  await ImagePicker.pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              File imageFile = File(image.path);
                                              if (image != null) {
                                                newImage = await compressImage(
                                                    imageFile);
                                              }
                                              setState(() {});
                                            },
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.file(
                                                  image,
                                                  fit: BoxFit.cover,
                                                ))),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(30),
                                  ),
                                  Container(
                                    height: getProportionateScreenHeight(30),
                                    alignment: appLocal == "ar"
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: AutoSizeText(
                                      "وصف للخدمة".i18n,
                                      style: body3_18pt,
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(20),
                                  ),
                                  Container(
                                    // height: getProportionateScreenHeight(65),
                                    width: SizeConfig.screenWidth,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.6),
                                            width: 1)),
                                    child: CustomTextField(
                                      textEditingController:
                                          descriptionController,
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(25),
                                  ),
                                  // Container(
                                  //   height: getProportionateScreenHeight(30),
                                  //   alignment: Alignment.centerRight,
                                  //   child: AutoSizeText(
                                  //     "السعر",
                                  //     style: body3_18pt,
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: getProportionateScreenHeight(25),
                                  // ),
                                  // Container(
                                  //   height: getProportionateScreenHeight(65),
                                  //   width: SizeConfig.screenWidth,
                                  //   decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(8),
                                  //       border: Border.all(
                                  //           color: Colors.grey.withOpacity(0.6), width: 1)),
                                  //   child:
                                  // ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(25),
                                  ),
                                  Container(
                                    height: getProportionateScreenHeight(60),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                            onTap: () async {
                                              if (nameController.text == "" ||
                                                  priceController.text == "" ||
                                                  descriptionController.text ==
                                                      "") {
                                                CoolAlert.show(
                                                  context: context,
                                                  type: CoolAlertType.error,
                                                  text:
                                                      "الرجاء ملئ كافة الحقول قبل اضافة الخدمة"
                                                          .i18n,
                                                );
                                                return;
                                              }
                                              if (image == null) {
                                                CoolAlert.show(
                                                  context: context,
                                                  type: CoolAlertType.error,
                                                  text:
                                                      "الرجاء اضافة صورة الخدمة"
                                                          .i18n,
                                                );
                                                return;
                                              }

                                              // widget.storeProduct.id;
                                              // widget.storeProduct.image;

                                              await widget.doctorController
                                                  .addNewService(
                                                      category_id: categoryId,
                                                      // type_id:typeId,
                                                      name_ar:
                                                          nameController.text,
                                                      name_en:
                                                          nameController.text,
                                                      body_ar:
                                                          descriptionController
                                                              .text,
                                                      body_en:
                                                          descriptionController
                                                              .text,
                                                      image: newImage,
                                                      price:
                                                          priceController.text);
                                              // vendorAppTabController.animateTo(0);
                                              // vendorAppLabelController.changeIndex(0);
                                            },
                                            child: Container(
                                              width:
                                                  getProportionateScreenWidth(
                                                      170),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  gradient: blueGradient),
                                              child: Center(
                                                child: AutoSizeText(
                                                  "إضافة ".i18n,
                                                  style: blueButton_14pt,
                                                ),
                                              ),
                                            )),
                                        GestureDetector(
                                            onTap: () {
                                              // vendorAppTabController.animateTo(0);
                                              // vendorAppLabelController.changeIndex(0);
                                              Get.back();
                                            },
                                            child: Container(
                                              width:
                                                  getProportionateScreenWidth(
                                                      170),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  border: Border.all(
                                                      color: Color(0xFF49C3EA),
                                                      width: 0.8)),
                                              child: Center(
                                                child: AutoSizeText(
                                                  "العودة".i18n,
                                                  style: body2_14pt,
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(20),
                                  )
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
