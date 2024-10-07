import 'package:ecom/share/constants/image_string.dart';
import 'package:ecom/share/constants/sizes.dart';
import '../../../../../share/constants/colors.dart';
import '../../../../../share/global_variable/global_variable.dart';
import 'package:flutter/material.dart';

class VerifyEmailSuccess {

  static final context = NavigationService.navigatorKey.currentContext!;

  static void showVerifyEmailSuccess({String? title,  required  String subTitle, required String buttonText, required VoidCallback onPressed}) {
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
                            const SizedBox(
                              height: TSizes.spaceBtwSections * 2,
                            ),
                            const Image(
                              image: AssetImage(TImages.verifyEmail),
                              width: 300,
                            ),
                            const SizedBox(
                              height: TSizes.sm,
                            ),
                            Text(
                             title ?? 'Email Verified Successfully',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .apply(color: TColors.primary),
                            ),
                            const SizedBox(height: TSizes.sm,),
                            Text(
                              subTitle,
                              style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.darkerGrey),
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwItems,
                            ),
                            SizedBox(
                                width: 120,
                                height: 40,
                                child: ElevatedButton(
                                    onPressed: onPressed,
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(1),
                                        visualDensity: const VisualDensity(
                                            horizontal: 1, vertical: 1)),
                                    child: Text(buttonText))),
                            const SizedBox(
                              height: TSizes.spaceBtwSections,
                            ),
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

  static void stopVerifyEmailSuccess() {
    Navigator.of(context).pop();
  }

}