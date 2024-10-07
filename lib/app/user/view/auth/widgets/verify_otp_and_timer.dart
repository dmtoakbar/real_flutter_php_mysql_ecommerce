import 'package:ecom/app/user/controller/otp_validate_and%20_resend.dart';
import 'package:ecom/share/constants/image_string.dart';
import 'package:ecom/share/constants/sizes.dart';
import 'package:flutter/services.dart';

import '../../../../../share/constants/colors.dart';
import '../../../../../share/global_variable/global_variable.dart';
import 'package:flutter/material.dart';

class VerifyOtpAndTimer {

  static final context = NavigationService.navigatorKey.currentContext!;

  static void showFormAndTimer({required String email, required int otp, required int expiry, bool forgetPassword=false}) {
    TextEditingController userInterOtp = TextEditingController();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => PopScope(
            canPop: false,
            child: Scaffold(
              body: Container(
                color: TColors.white,
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: TSizes.spaceBtwSections * 2,),
                           const Image(image: AssetImage(TImages.sendEmail), width: 300,),
                            const SizedBox(height: TSizes.sm,),
                            Text('OTP Successfully sent...', style: Theme.of(context).textTheme.titleLarge!.apply(color: TColors.primary),),
                            Text(email, style: Theme.of(context).textTheme.bodyLarge,),
                            const SizedBox(height: TSizes.spaceBtwItems,),
                            Material(
                              child: SizedBox(
                                width: 250,
                                child: TextField(
                                  controller: userInterOtp,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(5)
                                  ],
                                  decoration: const InputDecoration(
                                    hintText: 'Enter OTP . . .',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: TSizes.sm,),
                            SizedBox(
                              width: 250,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                    child: TextButton(onPressed: () {
                                      OtpValidateAndResend.resendOtp(email: email, forgetPassword: forgetPassword);
                                    },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.grey
                                        ),
                                        child: Text('Re-send', style: Theme.of(context).textTheme.labelMedium!.apply(color: Colors.white),)),
                                  ),
                                  const SizedBox(height: 3,),
                                  Text('Valid for only 5 minutes', style: Theme.of(context).textTheme.labelMedium,)
                                ],
                              ),
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems /2,),
                            SizedBox(
                              width: 120,
                                height: 40,
                                child: ElevatedButton(onPressed: () {
                                  final int userOtp = int.parse(userInterOtp.text);
                                  OtpValidateAndResend.validateOtp(email: email, opt: otp, expiry: expiry, userInterOtp: userOtp, forgetPassword: forgetPassword);
                                },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(1),
                                      visualDensity: const VisualDensity(horizontal: 1, vertical: 1)
                                    ),
                                    child: const Text('Verify'))
                            ),
                            const SizedBox(height: TSizes.spaceBtwSections,),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
        )
    );
  }

  static void stopShowFormAndTimer() {
    Navigator.of(context).pop();
  }

}