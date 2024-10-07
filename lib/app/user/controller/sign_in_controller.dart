import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecom/app/user/authentication/redirect_screen.dart';
import 'package:ecom/app/user/authentication/set_user_login_for_future.dart';
import 'package:ecom/app/user/controller/send_email.dart';

import '../../../helper/api_handller.dart';
import '../../../share/constants/api_constant.dart';
import '../../../share/global_variable/global_variable.dart';
import '../../../share/network/internet_connection.dart';
import '../../../share/route/route_names.dart';
import '../../../share/route/routes.dart';
import '../../../share/widgets/loaders/full_screen_loader.dart';
import '../../../share/widgets/snackbar/snackbar.dart';
import '../view/auth/widgets/verify_otp_and_timer.dart';
import 'generate_otp_expiry_time.dart';

class SingInController {
  static final context = NavigationService.navigatorKey.currentContext!;

  static redirectScreen({required String routeName}) {
    CustomRoute.replace(context, routeName);
  }
  static void signIn({required String email, required String password, bool? rememberMe}) async {

    final postData = {
      'email': email,
      'password': password
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

      // send data to server
      final response =
      await GetDio.getDio().post(ApiEndPoints.baseURL+ApiEndPoints.userSignIn, data: formData);
      final value = jsonDecode(response.data);
      // check different condition
      if(value != null ) {
        final int status = value['status'];
        final String message = value['message'];
        if(status==1 || status ==2) {

          if(status==1) {
            TFullScreenLoader.stopLoading();
            CustomSnackbar.successSnackbar(message: message);
            if(rememberMe!){
              SetUserLoginDataForFuture.setUserLoginData(email: email, password: password);
            }
            RedirectScreen.setLoginStatus(email: email);
            redirectScreen(routeName: TRouteNames.userBottomNavigation);
          } else if(status ==2) {
            // send mail
            final otpAndExpiry = GenerateOtpAndExpiryTime.generateOtpAndExpiry();
            final int otp = otpAndExpiry['otp'];
            final int expiry = otpAndExpiry['minutes'];
            final bool emailStatus = await SendEmailUser.sendEmail(recipientEmail: email, otp: otp);
            if(emailStatus) {
              TFullScreenLoader.stopLoading();
              CustomSnackbar.warningSnackbar(message: message);
              VerifyOtpAndTimer.showFormAndTimer(email: email, otp: otp, expiry: expiry);
            } else {
              TFullScreenLoader.stopLoading();
              CustomSnackbar.errorSnackbar(message: "Something went wrong, Please try again...");
            }
            // end send email
          }

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
}