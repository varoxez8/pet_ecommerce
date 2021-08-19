import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pets_ecommerce/configuration/constants/api.dart';
import 'package:pets_ecommerce/configuration/constants/text_style.dart';
import 'package:pets_ecommerce/configuration/printer.dart';
import 'package:pets_ecommerce/configuration/size_config.dart';
import 'package:pets_ecommerce/screens/doctors/model/review_model.dart';

import 'package:pets_ecommerce/screens/home/view/components/social_media_components.dart';
import 'package:pets_ecommerce/screens/stores/view/components/about/review_card.dart';
import 'package:http/http.dart' as http;
import 'package:pets_ecommerce/screens/vendor_app/model/store.dart';
import 'package:pets_ecommerce/services/http_requests_service.dart';
// import 'package:rating_dialog/rating_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../loading_screen.dart';
import 'package:get/get.dart';
import '../../../model/custome_store_body.dart';
class AboutStoreBodyScreen extends StatefulWidget {
  int id;
  AboutStoreBodyScreen(this.id);
  @override
  _AboutStoreBodyScreenState createState() => _AboutStoreBodyScreenState();
}

class _AboutStoreBodyScreenState extends State<AboutStoreBodyScreen> {




  ReviewModel reviewModel;
  getReviews()async {
    eerror=false;
    lloading=true;
    setState(() {

    });
    consolePrint("befor get ");
    final h=await HttpService().getHeaders();
    try{
      final apiResult = await http.get(
          Api.baseUrl + Api.getStoreReview + widget.id.toString(),
          headers: h);
      consolePrint("after get ");
      if (apiResult.statusCode == 200)
        reviewModel = reviewModelFromJson(apiResult.body);
      else
        eerror = true;
    }catch(e)
    {
      consolePrint(e.toString());
      lloading=false;
      setState(() {

      });
      eerror=true;
    }
    lloading=false;
    setState(() {

    });
  }
  addReview(String comment,int rate)
  async {
    lloading=true;
    setState(() {

    });
    consolePrint("befor add ");
    final h=await HttpService().getHeaders();
    var m={
      "rate":rate.toString(),
      "comment":comment.toString(),
      "store_id":widget.id.toString(),
    };
    // FormData formData=FormData({
    //
    // });
    var j=jsonEncode(m);
    final apiResult = await http.post(
        Api.baseUrl+Api.addDoctorReview,body: m //+ '/' + widget.id.toString()
        ,headers: h);
    consolePrint("after add ");
    consolePrint(apiResult.statusCode.toString());
    consolePrint(apiResult.body);
    if(apiResult.statusCode==200)
    {

    }
    // doctorModel= doctorModelFromJson(apiResult.body);

    else eerror=true;

    lloading=false;
    setState(() {

    });
  }

  bool error=false;
  bool eerror=false;
  bool loading=false;
  bool lloading=false;
  String fb;
  String ins;
  String  wa;
  bool bfb=false;
  bool bins=false;
  bool  bwa=false;

  CustomerStoreBody storeModel;
  getData()
  async {
    loading=true;
    setState(() {

    });
    consolePrint(widget.id.toString());
    final h=await HttpService().getHeaders();
    var url=Uri.parse("http://pets.sourcecode-ai.com/api/about/store/${widget.id}");
    final apiResult =await http.get(url,headers: h);

    if(apiResult.statusCode==200)
    {


      storeModel =customerStoreBodyFromJson(apiResult.body);

// store=storeModel.store;

for(int i =0; i<storeModel.store.storeContacts.length;i++)
  {
    if(storeModel.store.storeContacts[i].type=="facebook"&&bfb==true)
      {
        fb=storeModel.store.storeContacts[i].link;
bfb=true;
      }
    else if(storeModel.store.storeContacts[i].type=="phone"&&bwa==true)
      {
        wa=storeModel.store.storeContacts[i].link;
bwa=false;
      }
    else if (storeModel.store.storeContacts[i].type=="instagram"&&bins==true)
    {
      ins=storeModel.store.storeContacts[i].link;
      bins=false;
    }
  }

    }
    else
    {
      error=true;
    }

    loading=false;
    setState(() {

    });


  }


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getReviews();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return   error?Container(
      margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
      child: AutoSizeText("عذرا حدثت مشكلة الرجاء المحاولة مجددا"),
    ):loading?LoadingScreen():Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(24),
              vertical: getProportionateScreenHeight(16)),
          child: ListView(
            children: [
              Row(

                children: [
                  AutoSizeText(
                    storeModel.store.name,
                    style: h5_25pt,
                    minFontSize: 16,
                  ),
                  Spacer(),
                  SocialMedia(fb: fb,ins: ins,wa: wa,freez: false,),
                ],
              ),
              ///first row
              SizedBox(
                height: getProportionateScreenHeight(16),
              ),
              Container(
                height: getProportionateScreenHeight(25),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Icon(Icons.location_on_rounded,color: Colors.grey,size: 16,),
                    Image.asset(
                      "assets/images/home/location_icon.png",
                      height: getProportionateScreenHeight(12),
                      width: getProportionateScreenWidth(12),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(10),
                    ),
                    AutoSizeText(
                     storeModel.store.district,
                      // minFontSize: 8,
                      style: darkGrayText_13pt,
                    ),
                  ],
                ),
              ),

              ///location
              SizedBox(
                height: getProportionateScreenHeight(25),
              ),
              Container(
                height: getProportionateScreenHeight(30),
                alignment: Alignment.centerRight,
                child: AutoSizeText(
                  "مواعيد العمل",
                  minFontSize: 14,
                  style: body3_18pt,
                  maxLines: 1,
                ),
              ),

              ///مواعيد العمل
              SizedBox(
                height: getProportionateScreenHeight(16),
              ),

              for(int i=0;i<storeModel.store.storeWorksDays.length;i++)
              Container(
                margin: EdgeInsets.symmetric(vertical: 3),
                child: Row(
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
                      child: Row(
                        children: [
                          Container(
                            height: getProportionateScreenHeight(20),
                            width: getProportionateScreenWidth(50),
                            child: AutoSizeText(
                              "${storeModel.store.storeWorksDays[i].day} ",textDirection: TextDirection.rtl,
                              style: body3_18pt,
                              minFontSize: 10,
                            ),
                          ),
                          Container(
                            height: getProportionateScreenHeight(20),
                            // width: getProportionateScreenWidth(120),
                            child: AutoSizeText(
                              "${storeModel.store.storeWorksDays[i].from} ",textDirection: TextDirection.ltr,
                              style: body3_18pt,
                              minFontSize: 10,
                            ),
                          ),
                          Container(
                            height: getProportionateScreenHeight(20),
                            // width: getProportionateScreenWidth(120),
                            child: AutoSizeText(
                              "-",
                              style: body3_18pt,
                              minFontSize: 10,
                            ),
                          ),
                          Container(
                            height: getProportionateScreenHeight(20),
                            // width: getProportionateScreenWidth(120),
                            child: AutoSizeText(
                              "${storeModel.store.storeWorksDays[i].to} ",textDirection: TextDirection.ltr ,
                              style: body3_18pt,
                              minFontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(105)
                ),
                width: getProportionateScreenWidth(150),
                height: getProportionateScreenHeight(60),
                alignment: Alignment.center,
                // color: Colors.green,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   GestureDetector(onTap: ()async{
                      if (await canLaunch('tel:${storeModel.store.phone}')) {
                      await launch('tel:${storeModel.store.phone}');
                      } else {
                      Get.rawSnackbar(message: "عذرا فشلت العملية !",);
                      }
                    },child: Container(width: getProportionateScreenWidth(60),height:getProportionateScreenHeight(60),child: Image.asset("assets/images/store/phone_button_icon.png"))),
                   SizedBox(width: getProportionateScreenWidth(12),),
        GestureDetector(
            onTap: ()async{
if(storeModel.store.email==null)
  {
    Get.rawSnackbar(message: "عذرا المتجر ليس له بريد الكتروني !",);
    return ;
  }
else {
  if (await canLaunch( 'mailto:${storeModel.store.email}')) {
              await launch( 'mailto:${storeModel.store.email}');
              } else {
              Get.rawSnackbar(message: "عذرا فشلت العملية !",);
              }
}
        },

            child: Container(width: getProportionateScreenWidth(60),height:getProportionateScreenHeight(60),child: Image.asset("assets/images/store/email_buttom_icon.png"))),
                  ],
                ),
              ),
              // SizedBox(
              //   height: getProportionateScreenHeight(15),
              // ),
              // Row(
              //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(height:getProportionateScreenHeight(30), child: AutoSizeText("احدث التقييمات",style:body3_18pt,minFontSize: 12,maxLines: 1,)),
              //     Spacer(),
              //     Container(height:getProportionateScreenHeight(15),child: AutoSizeText("عرض المزيد ",style: body2_14pt,minFontSize: 8,)),
              //   ],
              // ),
              // SizedBox(height: getProportionateScreenHeight(10),),
              // GestureDetector(onTap:()async{
              //   // final ratingDialog= RatingDialog(
              //   //   // your app's name?
              //   //   title: storeModel.store.name,
              //   //   ratingColor: Colors.blue.withOpacity(0.8),
              //   //   // encourage your user to leave a high rating?
              //   //   message:
              //   //   'ماهو تقيمك لهذا الطبيب  ؟',
              //   //   commentHint: 'اخبرنا برئيك عن هذا الطبيب',
              //   //   // your app's logo?
              //   //   // image: Container(
              //   //   //   color: ,
              //   //   // ),
              //   //   submitButton: 'متابعة',
              //   //   onCancelled: () => Get.back(),
              //   //   onSubmitted: (response) async{
              //   //     print('rating: ${response.rating}, comment: ${response.comment}');
              //   //     await addReview(response.comment, response.rating);
              //   //   },
              //   // );
              //   //
              //   // showDialog(context: context, builder: (context)=>ratingDialog);
              // },
              //     child: Container(width: getProportionateScreenWidth(300),height: getProportionateScreenHeight(50),color: Colors.redAccent,)),
              //
              // eerror?Container(
              //   height: getProportionateScreenHeight(200),
              //   width: getProportionateScreenWidth(300),
              //   child: AutoSizeText(
              //     "عذرا حدثت مشكلة بجلب التقيمات الرجاء المحاولة مجدداً",
              //     style: body1_16pt,
              //   ),
              // ):lloading?Container(height: getProportionateScreenHeight(200),
              //   width: getProportionateScreenWidth(300),
              //   child: Container(
              //     alignment: Alignment.center,
              //     child: CircularProgressIndicator(),
              //
              //   ),
              // ):
              // Column(
              //   children: [
              //     ...List<Widget>.generate(reviewModel.rates.length,(index)=>ReviewCad(reviewModel.rates[index].userComment, reviewModel.rates[index].userName, reviewModel.rates[index].userRate,reviewModel.rates[index].userImage))
              //   ],
              // ),

              SizedBox(height: getProportionateScreenHeight(25),),
              Container(width: getProportionateScreenWidth(370),height: getProportionateScreenHeight(152),child: Image.asset("assets/images/store/map.png",fit: BoxFit.fill,),)
            ],
          ),
        ),
      );
  }
}
