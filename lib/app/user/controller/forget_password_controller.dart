import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecom/app/user/controller/send_email.dart';
import 'package:ecom/app/user/view/auth/widgets/forget_password_form.dart';

import '../../../helper/api_handller.dart';
import '../../../share/constants/api_constant.dart';
import '../../../share/global_variable/global_variable.dart';
import '../../../share/network/internet_connection.dart';
import '../../../share/route/route_names.dart';
import '../../../share/route/routes.dart';
import '../../../share/widgets/loaders/full_screen_loader.dart';
import '../../../share/widgets/snackbar/snackbar.dart';
import '../view/auth/widgets/verify_email_success.dart';
import '../view/auth/widgets/verify_otp_and_timer.dart';
import 'generate_otp_expiry_time.dart';

class ForgetPasswordController {
  static final context = NavigationService.navigatorKey.currentContext!;

 static Future forgetPassword({required String email}) async {
   final postData = {
     'email': email
   };
   final formData = FormData.fromMap(postData);
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

     // check email is register or not
     final response =
     await GetDio.getDio().post(ApiEndPoints.baseURL+ApiEndPoints.userRegisterCheck, data: formData);
     final value = jsonDecode(response.data);
     // check different condition
     if(value != null) {
        final status = value['status'];
        final message = value['message'];
        if(status==1) {
          final otpAndExpiry = GenerateOtpAndExpiryTime.generateOtpAndExpiry();
          final int otp = otpAndExpiry['otp'];
          final int expiry = otpAndExpiry['minutes'];
          final bool emailStatus = await SendEmailUser.sendEmail(recipientEmail: email, otp: otp);
          if(emailStatus) {
            TFullScreenLoader.stopLoading();
            CustomSnackbar.successSnackbar(message: "OTP sent successfully on your email..");
            VerifyOtpAndTimer.showFormAndTimer(email: email, otp: otp, expiry: expiry, forgetPassword: true);
          } else {
            TFullScreenLoader.stopLoading();
            CustomSnackbar.errorSnackbar(message: "Something went wrong, Please try again...");
          }
          // end send email
        } else {
          TFullScreenLoader.stopLoading();
          CustomSnackbar.errorSnackbar(message: message);
        }

     } else {
       TFullScreenLoader.stopLoading();
       CustomSnackbar.errorSnackbar(message: "Something went wrong, Please try again..");
     }

   } catch (e) {
     TFullScreenLoader.stopLoading();
     CustomSnackbar.errorSnackbar(message: "Something went wrong, Please try again..");
   }
 }

 // update password
 static Future updatePassword({required String email, required String password}) async {
   final postData = {
     'email': email,
     'password': password
   };
   final formData = FormData.fromMap(postData);
   try {
     // stop forget password form
     ForgetPasswordForm.stopForgetPasswordForm();
     // full screen loader
     TFullScreenLoader.openLoadingDialog(text: "Processing request...");

     // check email is register or not
     final response =
     await GetDio.getDio().post(ApiEndPoints.baseURL+ApiEndPoints.userForgetPassword, data: formData);
     final value = jsonDecode(response.data);
     // check different condition
     if(value != null) {
       final status = value['status'];
       final message = value['message'];
       if(status==1) {
         TFullScreenLoader.stopLoading();
         CustomSnackbar.successSnackbar(message: message);
         VerifyEmailSuccess.showVerifyEmailSuccess(title: 'Your password updated successfully', subTitle: 'Save for future use...', buttonText: "Login Now", onPressed: () {
           VerifyEmailSuccess.stopVerifyEmailSuccess();
           CustomRoute.replace(context, TRouteNames.login);
         });

       } else {
         TFullScreenLoader.stopLoading();
         CustomSnackbar.errorSnackbar(message: message);
       }

     } else {
       TFullScreenLoader.stopLoading();
       CustomSnackbar.errorSnackbar(message: "Something went wrong, Please try again..");
     }

   } catch (e) {
     TFullScreenLoader.stopLoading();
     CustomSnackbar.errorSnackbar(message: "Something went wrong, Please try again..");
   }
 }

}