
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecom/app/user/controller/generate_otp_expiry_time.dart';
import 'package:ecom/app/user/controller/send_email.dart';
import 'package:ecom/app/user/view/auth/widgets/verify_otp_and_timer.dart';
import 'package:ecom/share/network/internet_connection.dart';
import 'package:ecom/share/widgets/loaders/full_screen_loader.dart';
import 'package:ecom/share/widgets/snackbar/snackbar.dart';

import '../../../helper/api_handller.dart';
import '../../../share/constants/api_constant.dart';

class UserAuthController {
  //------------------------------ register user ----------------------
  static Future userRegister(
      {required String name,
      required String email,
      required String password,
      required String code}
      ) async {

    var postData = {
      "name": name,
      "email": email,
      "password": password,
      "code": code,
    };
    var formData = FormData.fromMap(postData);

    try {
      // full screen loader
      TFullScreenLoader.openLoadingDialog(text: "Processing request...");

      // check internet connection
      final internet = await CheckInternetConnection.internetConnection();
      if(!internet) {
        TFullScreenLoader.stopLoading();
        CustomSnackbar.errorSnackbar(message: 'No internet connection');
        return;
      }

      // send data to server
      final response =
      await GetDio.getDio().post(ApiEndPoints.baseURL+ApiEndPoints.userRegister, data: formData);
      final value = jsonDecode(response.data);
      // check different condition
      if(value != null ) {
        final int status = value['status'];
        final String message = value['message'];
        if(status==1 || status ==4) {
          // send mail
          final otpAndExpiry = GenerateOtpAndExpiryTime.generateOtpAndExpiry();
          final int otp = otpAndExpiry['otp'];
          final int expiry = otpAndExpiry['minutes'];
          final bool emailStatus = await SendEmailUser.sendEmail(recipientEmail: email, otp: otp);
          if(emailStatus) {
            TFullScreenLoader.stopLoading();
            CustomSnackbar.successSnackbar(message: "OTP sent successfully on your email..");
            VerifyOtpAndTimer.showFormAndTimer(email: email, otp: otp, expiry: expiry);
          } else {
            TFullScreenLoader.stopLoading();
            CustomSnackbar.errorSnackbar(message: "Something went wrong, Please try again...");
          }
          // end send email
        } else if(status==2) {
         TFullScreenLoader.stopLoading();
         CustomSnackbar.errorSnackbar(message: message);
        } else {
          TFullScreenLoader.stopLoading();
          CustomSnackbar.errorSnackbar(message: message);
        }
      } else {
        TFullScreenLoader.stopLoading();
        CustomSnackbar.errorSnackbar(message: "Something went wrong, Please try again...");
      }

    } catch (e) {
      TFullScreenLoader.stopLoading();
      CustomSnackbar.errorSnackbar(message: "Something went wrong, Please try again..");
    }

  }
  // -------------------------- end register user -------------------------------------
}

