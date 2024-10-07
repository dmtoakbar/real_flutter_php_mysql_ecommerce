import 'package:ecom/share/constants/colors.dart';
import 'package:ecom/share/constants/image_string.dart';
import 'package:ecom/share/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../../global_variable/global_variable.dart';

class TFullScreenLoader {
  static final context = NavigationService.navigatorKey.currentContext!;

  static void openLoadingDialog({required String text}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => PopScope(
           canPop: false,
            child: Container(
              color: TColors.white,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(image: AssetImage(TImages.requestProcessing)),
                        const SizedBox(height: TSizes.spaceBtwItems/2,),
                        Text(text, style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.primary), textAlign: TextAlign.center,)
                      ],
                    ),
                  )
                ],
              ),
            )
        )
    );
  }

  static void stopLoading() {
    Navigator.of(context).pop();
  }
}