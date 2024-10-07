import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ecom/app/user/view/auth/widgets/forget_password_form.dart';

import '../../../helper/api_handller.dart';
import '../../../share/constants/api_constant.dart';
import '../../../share/global_variable/global_variable.dart';
import '../../../share/route/route_names.dart';
import '../../../share/route/routes.dart';
import '../../../share/widgets/loaders/full_screen_loader.dart';
import '../../../share/widgets/snackbar/snackbar.dart';
import '../view/auth/widgets/verify_email_success.dart';

class VerifyEmailController {
  static final context = NavigationService.navigatorKey.currentContext!;
  static Future verifyEmail({required String email, required int otp, required int verified, required bool forgetPassword}) async {
    Map<String, dynamic> postData = {
      "email": email,
      "otp": otp,
      "verified": verified,
    };
    var formData = FormData.fromMap(postData);
     try {
    final response =
    await GetDio.getDio().post(ApiEndPoints.baseURL+ApiEndPoints.userEmailVerification, data: formData);
    final value = jsonDecode(response.data);
    // check different condition
     if(value['status'] == 1) {
       TFullScreenLoader.stopLoading();
       CustomSnackbar.successSnackbar(message: value['message']);
       if(forgetPassword) {
         ForgetPasswordForm.showForgetPasswordForm(email: email);
       } else {
          VerifyEmailSuccess.showVerifyEmailSuccess(subTitle: 'Your account created successfully', buttonText: "Login Now", onPressed: () {
           VerifyEmailSuccess.stopVerifyEmailSuccess();
           CustomRoute.replace(context, TRouteNames.login);
         });
       }
     } else {
       TFullScreenLoader.stopLoading();
       CustomSnackbar.errorSnackbar(message: value['message']);
     }

     } catch (e) {
       TFullScreenLoader.stopLoading();
       CustomSnackbar.errorSnackbar(message: "Something went wrong, Please try again..");
     }

  }
}