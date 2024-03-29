import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets/configuration/printer.dart';
import 'package:pets/screens/doctor_app/model/doctor.dart';
import 'package:pets/screens/doctor_app/requests/doctor_info_requests.dart';
import 'package:pets/screens/vendor_app/model/location_model.dart';
import 'translations/doctor_controller.i18n.dart';
import 'dart:io';
import 'package:image/image.dart' as Im;

class DoctorController extends GetxController {
  DoctorModel doctorModel;
  LocationModel locationModel;
  bool init = false;
  DoctorAppRequests doctorAppRequests = DoctorAppRequests();
  bool isLoading = false;

  fetchData() async {
    setLoading();
    locationModel = await doctorAppRequests.getLocations();
    await doctorAppRequests.getModel();
    await getDoctorInfo();
    init = true;
    removeLoading();
    update();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    fetchData();
  }

  getDoctorInfo() async {
    doctorModel = await doctorAppRequests.getDoctorInfo();
    removeLoading();
    update();
  }

  changeLocation(int value) async {
    try {
      setLoading();
      bool k = await doctorAppRequests.updateAddress(address: value);
      if (k == true) {
        await getDoctorInfo();
        removeLoading();
      } else {
        removeLoading();
        Get.rawSnackbar(
            message:
                "عذراً لم نتمكن من تحديث معلومات الطبيب الرجاء المحاولة مجدداً"
                    .i18n,
            backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      removeLoading();
    }
    update();
  }

  changeImage(String path) async {
    try {
      setLoading();
      bool k = await doctorAppRequests.updateImage(img: path);
      if (k == true) {
        await getDoctorInfo();
        removeLoading();
      } else {
        removeLoading();
        Get.rawSnackbar(
            message:
                "عذراً لم نتمكن من تحديث معلومات الطبيب الرجاء المحاولة مجدداً"
                    .i18n,
            backgroundColor: Colors.redAccent);
        update();
      }
    } catch (e) {
      removeLoading();
      update();
    }
  }

  setLatLong(double lat, double long) async {
    try {
      setLoading();
      bool k = await doctorAppRequests.setLatLong(lat: lat, long: long);
      if (k == true) {
        await getDoctorInfo();
        removeLoading();
      } else {
        removeLoading();
        Get.rawSnackbar(
            message:
                "عذراً لم نتمكن من اضافة موقعك الرجاء المحاولة مجدداً".i18n,
            backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      removeLoading();
      Get.rawSnackbar(
          message: "عذراً لم نتمكن من اضافة موقعك الرجاء المحاولة مجدداً".i18n,
          backgroundColor: Colors.redAccent);
      consolePrint(e.toString());
    }
    update();
  }

  changeTime(String t1, String t2) async {
    try {
      setLoading();
      bool k =
          await doctorAppRequests.updateOpenAtCloseAt(openAt: t1, closeAt: t2);
      if (k == true) {
        await getDoctorInfo();
        removeLoading();
      } else {
        removeLoading();
        Get.rawSnackbar(
            message:
                "عذراً لم نتمكن من تحديث أوقات دوام الطبيب الرجاء المحاولة مجدداً"
                    .i18n,
            backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      removeLoading();
      Get.rawSnackbar(
          message:
              "عذراً لم نتمكن من تحديث أوقات دوام الطبيب الرجاء المحاولة مجدداً"
                  .i18n,
          backgroundColor: Colors.redAccent);
    }
    update();
  }

  addTime(int id, String t1, String t2, bool vacation) async {
    try {
      setLoading();
      bool k = await doctorAppRequests.addOpenAtCloseAt(
        id: id, openAt: t1, closeAt: t2,
        // vacation: vacation?"vacation":""
      );
      if (k == true) {
        await getDoctorInfo();
        removeLoading();
      } else {
        removeLoading();
        Get.rawSnackbar(
            message:
                "عذراً لم نتمكن من اضافة أوقات دوام الطبيب الرجاء المحاولة مجدداً"
                    .i18n,
            backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      Get.rawSnackbar(
          message:
              "عذراً لم نتمكن من اضافة أوقات دوام الطبيب الرجاء المحاولة مجدداً"
                  .i18n,
          backgroundColor: Colors.redAccent);
      consolePrint(e.toString());
      removeLoading();
    }
    update();
  }

  editTime(int id, String t1, String t2, bool vacation) async {
    try {
      setLoading();
      consolePrint("id:" + id.toString());
      consolePrint("from:" + t1.toString());
      consolePrint("to:" + t2.toString());
      bool k = await doctorAppRequests.editOpenAtCloseAt(
          id: id,
          openAt: t1,
          closeAt: t2,
          vacation: vacation ? "vacation" : "b");
      if (k == true) {
        await getDoctorInfo();
        removeLoading();
      } else {
        removeLoading();
        Get.rawSnackbar(
            message:
                "عذراً لم نتمكن من تحديث أوقات دوام الطبيب الرجاء المحاولة مجدداً"
                    .i18n,
            backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      removeLoading();
      Get.rawSnackbar(
          message:
              "عذراً لم نتمكن من تحديث أوقات دوام الطبيب الرجاء المحاولة مجدداً"
                  .i18n,
          backgroundColor: Colors.redAccent);
    }
    update();
  }

  deleteTime(int id) async {
    try {
      setLoading();
      bool k = await doctorAppRequests.deleteOpenAtCloseAt(
        id: id,
      );
      if (k == true) {
        await getDoctorInfo();
        removeLoading();
      } else {
        removeLoading();
        Get.rawSnackbar(
            message:
                "عذراً لم نتمكن من حذف أوقات دوام الطبيب الرجاء المحاولة مجدداً"
                    .i18n,
            backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      removeLoading();
      Get.rawSnackbar(
          message:
              "عذراً لم نتمكن من حذف أوقات دوام الطبيب الرجاء المحاولة مجدداً"
                  .i18n,
          backgroundColor: Colors.redAccent);
    }
    update();
  }

  changeEmail(String email) async {
    try {
      setLoading();
      bool k = await doctorAppRequests.updateEmail(email: email);
      if (k == true) {
        await getDoctorInfo();
        removeLoading();
      } else {
        removeLoading();
        Get.rawSnackbar(
            message:
                "عذراً لم نتمكن من تحديث معلومات الطبيب الرجاء المحاولة مجدداً"
                    .i18n,
            backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      removeLoading();
      Get.rawSnackbar(
          message:
              "عذراً لم نتمكن من تحديث معلومات الطبيب الرجاء المحاولة مجدداً"
                  .i18n,
          backgroundColor: Colors.redAccent);
    }
    update();
  }

  changeInfo(String info) async {
    try {
      setLoading();
      bool k = await doctorAppRequests.updateInfo(info: info);
      if (k == true) {
        await getDoctorInfo();
        removeLoading();
      } else {
        removeLoading();
        Get.rawSnackbar(
            message:
                "عذراً لم نتمكن من تحديث معلومات الطبيب الرجاء المحاولة مجدداً"
                    .i18n,
            backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      removeLoading();
      Get.rawSnackbar(
          message:
              "عذراً لم نتمكن من تحديث معلومات الطبيب الرجاء المحاولة مجدداً"
                  .i18n,
          backgroundColor: Colors.redAccent);
    }
    update();
  }

  changeSocial({String link, String type, int socialId}) async {
    try {
      setLoading();
      bool k = await doctorAppRequests.updateSocial(
          link: link, type: type, SocialId: socialId);
      if (k == true) {
        await getDoctorInfo();
        removeLoading();
      } else {
        removeLoading();
        Get.rawSnackbar(
            message:
                "عذراً لم نتمكن من تحديث معلومات الطبيب الرجاء المحاولة مجدداً"
                    .i18n,
            backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      removeLoading();
      Get.rawSnackbar(
          message:
              "عذراً لم نتمكن من تحديث معلومات الطبيب الرجاء المحاولة مجدداً"
                  .i18n,
          backgroundColor: Colors.redAccent);
    }
    update();
  }

  AddSocial({String link, String type}) async {
    try {
      setLoading();
      bool k = await doctorAppRequests.addSocial(link: link, type: type);
      if (k == true) {
        await getDoctorInfo();
        removeLoading();
      } else {
        removeLoading();
        Get.rawSnackbar(
            message:
                "عذراً لم نتمكن من تحديث معلومات الطبيب الرجاء المحاولة مجدداً"
                    .i18n,
            backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      removeLoading();
      Get.rawSnackbar(
          message:
              "عذراً لم نتمكن من تحديث معلومات الطبيب الرجاء المحاولة مجدداً"
                  .i18n,
          backgroundColor: Colors.redAccent);
    }
    update();
  }

  DeleteSocial(int socialId) async {
    try {
      setLoading();
      bool k = await doctorAppRequests.deleteSocial(SocialId: socialId);
      if (k == true) {
        await getDoctorInfo();
        removeLoading();
      } else {
        removeLoading();
        Get.rawSnackbar(
            message:
                "عذراً لم نتمكن من تحديث معلومات الطبيب الرجاء المحاولة مجدداً"
                    .i18n,
            backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      removeLoading();
      Get.rawSnackbar(
          message:
              "عذراً لم نتمكن من تحديث معلومات الطبيب الرجاء المحاولة مجدداً"
                  .i18n,
          backgroundColor: Colors.redAccent);
    }
    update();
  }

  addNewService(
      {@required int category_id,
      // @required int type_id,
      @required String name_ar,
      @required String name_en,
      @required String body_ar,
      @required String body_en,
      @required String image,
      @required String price}) async {
    setLoading();

    try {
      bool k = await doctorAppRequests.AddService(
          category_id: category_id,
          // type_id: type_id,
          name_ar: name_ar,
          name_en: name_en,
          body_ar: body_ar,
          body_en: body_en,
          image: image,
          price: price);
      if (k == true) {
        await getDoctorInfo();
        Get.back();
        removeLoading();
      } else {
        Get.back();
        removeLoading();
        Get.rawSnackbar(
            message: "لم نتمكن من اضافة خدمتك الرجاء المحاولة مجدداً".i18n,
            backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      Get.back();
      removeLoading();
      Get.rawSnackbar(
          message: "لم نتمكن من اضافة خدمتك الرجاء المحاولة مجدداً".i18n,
          backgroundColor: Colors.redAccent);
    }
    update();
  }

  deleteService(DoctorService service) async {
    setLoading();

    try {
      bool k = await doctorAppRequests.deleteService(
          // category_id: product.categoryId,
          // type_id: product.typeId,
          // name_ar: product.name,
          // name_en: product.name,
          // body_ar: product.body,
          // body_en: product.body,
          // image: product.image,
          ServiceId: service.id);
      if (k == true) {
        await getDoctorInfo();
        // Get.back();
        removeLoading();
        update();
      } else {
        // Get.back();
        removeLoading();
        update();
        Get.rawSnackbar(
            message: "لم نتمكن من حذف خدمتك الرجاء المحاولة مجدداً".i18n,
            backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      // Get.back();
      removeLoading();
      update();
      Get.rawSnackbar(
          message: "لم نتمكن من حذف خدمتك الرجاء المحاولة مجدداً".i18n,
          backgroundColor: Colors.redAccent);
    }
  }

  editService(DoctorService service, String newImage) async {
    setLoading();

    try {
      bool k = await doctorAppRequests.UpdateService(
        category_id: service.categoryId,
        // type_id: product.typeId,
        name_ar: service.name,
        name_en: service.name,
        body_ar: service.desc,
        body_en: service.desc,
        serviceId: service.id,
        price: service.price,
        image: newImage == "" ? null : newImage,
      );

      consolePrint(" اسم الخرية " + service.name);
      if (k == true) {
        await getDoctorInfo();
        Get.back();
        removeLoading();
        update();
      } else {
        Get.back();
        removeLoading();
        update();
        Get.rawSnackbar(
            message: "لم نتمكن من تعديل خدمتك الرجاء المحاولة مجدداً".i18n,
            backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      Get.back();
      removeLoading();
      update();
      Get.rawSnackbar(
          message: "لم نتمكن من تعديل خدمتك الرجاء المحاولة مجدداً".i18n,
          backgroundColor: Colors.redAccent);
    }
  }

  setLoading() {
    isLoading = true;
    update();
  }

  removeLoading() {
    isLoading = false;
    update();
  }
}
