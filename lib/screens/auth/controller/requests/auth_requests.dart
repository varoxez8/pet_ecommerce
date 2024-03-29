import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:pets/configuration/constants/api.dart';
import 'package:pets/configuration/printer.dart';
import 'package:pets/screens/auth/controller/register_controller.dart';
import 'package:pets/screens/auth/controller/services/auth_services.dart';
import 'package:pets/screens/auth/model/user.dart';
import 'package:pets/screens/auth/view/register/register_screen.dart';
import 'package:pets/screens/main_screen/view/main_view.dart';
import 'package:pets/services/http_requests_service.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'auth_requests.i18n.dart';

class AuthRequest extends HttpService {
  // Future<ApiResponse> resetPasswordRequest({
  //   @required String phone,
  //   @required String password,
  //   @required String firebaseToken,
  // }) async {
  //   final apiResult = await postRequest(
  //     Api.forgotPassword,
  //     {
  //       "phone": phone,
  //       "password": password,
  //       "firebase_id_token": firebaseToken,
  //     },
  //   );
  //
  //   return ApiResponse.fromResponse(apiResult);
  //
  AuthRequest() {
    _auth.setSettings(appVerificationDisabledForTesting: true);
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  String phoneVerificationId;

  Future<bool> registerUserRequest({
    @required String firstName,
    @required String secondName,
    @required String mobile,
    @required String password,
    @required int address,
  }) async {
    final apiResult = await postRequest(
      Api.registerUser,
      {
        "first_name": firstName,
        "last_name": secondName,
        "mobile": mobile,
        "password": password,
        "district_id": address,
      },
    );
    if (apiResult.statusCode == 200)
      // {
      //   UserModel userModel =
      //       await loginRequest(mobile: mobile, password: password);
      //   if (userModel.error == false) {
      //     AuthServices.saveUser(userModel.toJson());
      //     return true;
      //   } else
      //     return false;
      // }
      return true;
    else
      return false;
  }

  Future<bool> registerStoreRequest({
    @required String store_name,
    // @required String secondName,
    @required String mobile,
    @required String password,
    @required int address,
  }) async {
    dio.FormData data = dio.FormData.fromMap(
      {
        "store_name": store_name,
        // "last_name":secondName,
        "phone": mobile,
        "password": password,
        "district_id": address,
      },
    );
    consolePrint("store_name" +
        store_name +
        // "last_name":secondName,
        "phone" +
        mobile +
        "password" +
        password +
        "district_id" +
        address.toString());
    try {
      consolePrint("brfore controller request");
      final apiResult = await postRequest(
        Api.registerStore,
        data,
      );
      consolePrint("after controller request");
      consolePrint(apiResult.statusCode.toString());
      if (apiResult.statusCode == 200)
        // {
        //   UserModel userModel =
        //       await loginRequest(mobile: mobile, password: password);
        //   if (userModel.error == false) {
        //     AuthServices.saveUser(userModel.toJson());
        //     return true;
        //   } else
        //     da false;
        // }
        //
        return true;
      else
        return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> registerStableRequest({
    @required String stable_name,
    // @required String secondName,
    @required String mobile,
    @required String password,
    @required int address,
  }) async {
    dio.FormData data = dio.FormData.fromMap({
      "store_name": stable_name,
      // "last_name":secondName,
      "phone": mobile,
      "password": password,
      "district_id": address,
    });
    final apiResult = await postRequest(Api.registerStable, data);
    if (apiResult.statusCode == 200)
      // {
      //   UserModel userModel =
      //       await loginRequest(mobile: mobile, password: password);
      //   if (userModel.error == false) {
      //     AuthServices.saveUser(userModel.toJson());
      //     return true;
      //   } else
      //     return false;
      // }
      return true;
    else
      return false;
  }

  Future<bool> registerSiveRequest({
    @required String stable_name,
    // @required String secondName,
    @required String mobile,
    @required String password,
    @required int address,
  }) async {
    dio.FormData data = dio.FormData.fromMap({
      "store_name": stable_name,
      // "last_name":secondName,
      "phone": mobile,
      "password": password,
      "district_id": address,
    });
    final apiResult = await postRequest(Api.registerSieve, data);
    if (apiResult.statusCode == 200)
      // {
      //   UserModel userModel =
      //       await loginRequest(mobile: mobile, password: password);
      //   if (userModel.error == false) {
      //     AuthServices.saveUser(userModel.toJson());
      //     return true;
      //   } else
      //     return false;
      // }
      return true;
    else
      return false;
  }

  Future<bool> registerDoctorRequest({
    @required String firstName,
    @required String secondName,
    @required String mobile,
    @required String password,
    @required int address,
  }) async {
    dio.FormData data = dio.FormData.fromMap(
      {
        "first_name": firstName,
        "last_name": secondName,
        "mobile": mobile,
        "password": password,
        "district_id": address,
      },
    );

    final apiResult = await postRequest(
      Api.registerDoctor,
      data,
    );

    if (apiResult.statusCode == 200)
      // {
      //   UserModel userModel =
      //       await loginRequest(mobile: mobile, password: password);
      //   if (userModel.error == false) {
      //     AuthServices.saveUser(userModel.toJson());
      //     return true;
      //   } else
      //     return false;
      // }
      return true;
    else
      return false;
  }

  Future<UserModel> loginRequest({
    @required String mobile,
    @required String password,
  }) async {
    if (mobile[0] == '+') {
      mobile = mobile.substring(1);
      mobile = "00" + mobile;
    }
    if (!(mobile[0] == '0' && mobile[1] == '0')) {
      mobile = "00" + mobile;
    }
    consolePrint(mobile);
    final apiResult = await postRequest(
        Api.login,
        {
          "mobile": mobile,
          "password": password,
        },
        includeHeaders: true);
    consolePrint(apiResult.data["status"].toString());
    if (apiResult.statusCode == 200 && apiResult.data["status"] != false) {
      consolePrint("saving user");
      consolePrint(apiResult.data.toString());
      UserModel userModel = UserModel.fromJson(apiResult.data);
      consolePrint(userModel.toString());
      if (userModel.user.approve != "pending" &&
          userModel.user.blockStatus != "blocked")
        AuthServices.saveUser(apiResult.data);
      return userModel;
    }
    // else if(apiResult.statusCode == 200 ){ }
    else {
      UserModel error = UserModel();
      error.error = true;
      return error;
    }
  }

  Future<bool> login({
    @required String mobile,
    @required String password,
  }) async {
    UserModel userModel =
        await loginRequest(mobile: mobile, password: password);
    if (userModel.error == false) {
      // AuthServices.saveUser(userModel);
      if (userModel.user.id != 146) AuthServices.isAuthenticated();
      return true;
    } else
      return false;
  }

  //
  Future<bool> logoutRequest() async {
    final apiResult = await getRequest(Api.logout);
    return false;
    // return ApiResponse.fromResponse(apiResult);
  }

//
// Future<ApiResponse> updateProfile({
//   File photo,
//   String name,
//   String email,
//   String phone,
// }) async {
//   final apiResult = await postWithFiles(
//     Api.updateProfile,
//     {
//       "_method": "PUT",
//       "name": name,
//       "email": email,
//       "phone": phone,
//       "photo": photo != null
//           ? await MultipartFile.fromFile(
//         photo.path,
//       )
//           : null,
//     },
//   );
//   return ApiResponse.fromResponse(apiResult);
// }
  Future<bool> isExist(String mobile) async {
    consolePrint(mobile);
    mobile = "00" + mobile.substring(1);
    final apiResult = await postRequest(
      Api.mobileExist,
      {
        "mobile": mobile,
      },
    );

    if (apiResult.statusCode == 200) {
      consolePrint(apiResult.data['message']);
      if (apiResult.data['message'] == "app.mobile does not  exist")
        return false;
      else
        return true;
    } else
      return true;
  }

  Future<bool> verifyPhoneNumber(String phone) async {
    consolePrint(phone);
    try {
      registerController.changeLoading(true);

      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (phoneAuthCredential) async {
          registerController.changeLoading(false);
          consolePrint("verify done");
// Get.to(MainScreen());
          registerController.changeToOtp();
          // setState(() {
          //   showLoading = false;
          // });
          //signInWithPhoneAuthCredential(phoneAuthCredential);
        },
        verificationFailed: (FirebaseAuthException verificationFailed) async {
          registerController.changeLoading(false);
          // Get.snackbar("OOPS!!!", "verification failed:"+verificationFailed.message,duration: five_sec);
          Get.rawSnackbar(
              message:
                  "حدثت مشكلة اثناء التحقق من الرقم  الرجاء المحاولة لاحقا "
                      .i18n,
              duration: five_sec);
          Get.back();
          consolePrint("verification failed:" + verificationFailed.message);
          // setState(() {
          //   showLoading = false;
          // });
          // _scaffoldKey.currentState.showSnackBar(
          //     SnackBar(content: Text(verificationFailed.message)));
        },
        codeSent: (verificationId, resendingToken) async {
          registerController.changeLoading(false);
          registerController.changeToOtp();
          // Get.to(MainScreen());
          phoneVerificationId = verificationId;
          consolePrint("code sent :\n verification id is" + verificationId);
          Get.rawSnackbar(
              message: "لقد قمنا بارسال رسالة الى الرقم".i18n + phone,
              duration: five_sec);
          // setState(() {
          //   showLoading = false;
          //   currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
          //   this.verificationId = verificationId;
          // });9
        },
        codeAutoRetrievalTimeout: (verificationId) async {},
      );
    } on FirebaseAuthException catch (e) {
      consolePrint("firebase exception" + e.message);
      Get.rawSnackbar(
          message:
              "حدثت مشكلة اثناء التحقق من الرقم  الرجاء المحاولة لاحقا ".i18n,
          duration: five_sec);
      Get.back();
      // _scaffoldKey.currentState
      //     .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  Future<bool> reVerifyPhoneNumber(String phone) async {
    consolePrint(phone);
    try {
      registerController.changeLoading(true);

      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (phoneAuthCredential) async {
          registerController.changeLoading(false);
          consolePrint("verify done");
// Get.to(MainScreen());
          registerController.changeToOtp();
          // setState(() {
          //   showLoading = false;
          // });
          //signInWithPhoneAuthCredential(phoneAuthCredential);
        },
        verificationFailed: (FirebaseAuthException verificationFailed) async {
          registerController.changeLoading(false);
          // Get.snackbar("OOPS!!!", "verification failed:"+verificationFailed.message,duration: five_sec);
          Get.rawSnackbar(
              message:
                  "حدثت مشكلة اثناء التحقق من الرقم  الرجاء المحاولة لاحقا "
                      .i18n,
              duration: five_sec);
          Get.back();
          consolePrint("verification failed:" + verificationFailed.message);
          // setState(() {
          //   showLoading = false;
          // });
          // _scaffoldKey.currentState.showSnackBar(
          //     SnackBar(content: Text(verificationFailed.message)));
        },
        codeSent: (verificationId, resendingToken) async {
          registerController.changeLoading(false);
          registerController.changeToOtp();
          // Get.to(MainScreen());
          phoneVerificationId = verificationId;
          consolePrint("code sent :\n verification id is" + verificationId);
          Get.rawSnackbar(
              message: "لقد قمنا بارسال رسالة الى الرقم".i18n + phone,
              duration: five_sec);
          // setState(() {
          //   showLoading = false;
          //   currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
          //   this.verificationId = verificationId;
          // });9
        },
        codeAutoRetrievalTimeout: (verificationId) async {},
      );
    } on FirebaseAuthException catch (e) {
      consolePrint("firebase exception" + e.message);
      Get.rawSnackbar(
          message:
              "حدثت مشكلة اثناء التحقق من الرقم  الرجاء المحاولة لاحقا ".i18n,
          duration: five_sec);
      Get.back();
      // _scaffoldKey.currentState
      //     .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  void signInWithPhoneAuthCredentialWithOtpCode(String otpCode) async {
    // setState(() {
    //   showLoading = true;
    // });

    try {
      registerController.changeLoading(true);
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: phoneVerificationId, smsCode: otpCode);

      final authCredential = await _auth.signInWithCredential(credential);

      // setState(() {
      //   showLoading = false;
      // });

      if (authCredential.user != null) {
        consolePrint("phone verified successfully");
        // Get.snackbar("Success", "Donnnnnnnnnnnnnnnnnnnnnnnnnnnnne!",duration: five_sec);
        try {
          bool k = await register2();

          consolePrint("backeend register " + k.toString());
        } catch (e) {
          registerController.changeLoading(false);
          consolePrint("backend register failed " + e.toString());
        }
        registerController.changeLoading(false);
        // consolePrint("backeend register "+k.toString());

        // Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      } else {
        registerController.changeLoading(false);
        consolePrint("failed to sign in with google");
        // registerController.changeToRegister();
        Get.rawSnackbar(
            messageText:
                Text("لقد قمت بادخال كود خاطئ الرجاء المحاولة لاحقا ".i18n),
            duration: five_sec);
      }
      ;
    } on FirebaseAuthException catch (e) {
      // setState(() {
      //   showLoading = false;
      // });
      registerController.changeLoading(false);
      registerController.changeToRegister();
      Get.rawSnackbar(
          message: "فشلت العملية الرجاء المحاولة مجدداً".i18n,
          duration: five_sec);
      consolePrint(" firebase error :" + e.message);
      // _scaffoldKey.currentState
      //     .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
