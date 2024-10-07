import 'package:ecom/app/user/controller/generate_otp_expiry_time.dart';
import 'package:ecom/app/user/controller/send_email.dart';
import 'package:ecom/app/user/controller/validate_otp.dart';
import 'package:ecom/app/user/controller/verify_email_controller.dart';
import 'package:ecom/app/user/view/auth/widgets/verify_otp_and_timer.dart';
import 'package:ecom/share/widgets/snackbar/snackbar.dart';

import '../../../share/global_variable/global_variable.dart';
import '../../../share/widgets/loaders/full_screen_loader.dart';

class OtpValidateAndResend {
  static final context = NavigationService.navigatorKey.currentContext!;

  static validateOtp({required String email, required int opt, required int expiry, required int userInterOtp, required bool forgetPassword}) async {
   final dataStatus =  ValidateOtp.validateOtp(time: expiry, generatedOtp: opt, userInterOtp: userInterOtp);
   final status = dataStatus['status'];
   final message = dataStatus['message'];
   if(status==1) {

       VerifyOtpAndTimer.stopShowFormAndTimer();
       // full screen loader
       TFullScreenLoader.openLoadingDialog(text: "Processing request...");
       VerifyEmailController.verifyEmail(email: email, otp: opt, verified: 1, forgetPassword: forgetPassword);

   } else if(status==2) {
     CustomSnackbar.errorSnackbar(message: message);
   } else {
     CustomSnackbar.errorSnackbar(message: message);
   }
  }

  //
  static resendOtp({required String email, required bool forgetPassword}) async {
    final otpAndExpiry = GenerateOtpAndExpiryTime.generateOtpAndExpiry();
    final int otp = otpAndExpiry['otp'];
    final int expiry = otpAndExpiry['minutes'];

    VerifyOtpAndTimer.stopShowFormAndTimer();
    TFullScreenLoader.openLoadingDialog(text: 'Processing request..');
    final bool emailStatus = await SendEmailUser.sendEmail(recipientEmail: email, otp: otp);
    if(emailStatus) {
      TFullScreenLoader.stopLoading();
      CustomSnackbar.successSnackbar(message: "OTP sent successfully on your email..");
      VerifyOtpAndTimer.showFormAndTimer(email: email, otp: otp, expiry: expiry, forgetPassword: forgetPassword);
    } else {
      TFullScreenLoader.stopLoading();
      CustomSnackbar.errorSnackbar(message: "Something went wrong, Please try again...");
    }
  }


}