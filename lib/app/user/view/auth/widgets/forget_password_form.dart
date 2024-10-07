import 'package:ecom/app/user/controller/forget_password_controller.dart';
import 'package:ecom/share/constants/image_string.dart';
import 'package:ecom/share/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../share/constants/colors.dart';
import '../../../../../share/global_variable/global_variable.dart';
import 'package:flutter/material.dart';

class ForgetPasswordForm {

  static final context = NavigationService.navigatorKey.currentContext!;

  static void showForgetPasswordForm({required String email}) {
    TextEditingController password = TextEditingController();
    TextEditingController cmfPassword = TextEditingController();

    final formKey = GlobalKey<FormState>();
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
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                              child: Text('Create Strong Password And Save It For future Use', style: Theme.of(context).textTheme.titleLarge!.apply(color: TColors.primary), textAlign: TextAlign.center,),
                            ),
                            Text(email, style: Theme.of(context).textTheme.bodyLarge,),
                            const SizedBox(height: TSizes.spaceBtwItems,),
                            Material(
                              child: Form(
                                key: formKey,
                                child: Container(
                                  width: 300,
                                  constraints: const BoxConstraints(minWidth: 250, maxWidth: 400),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: password,
                                        obscureText: true,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                            labelText: 'Password',
                                            hintText: 'Enter your password',
                                            prefixIcon: Icon(Iconsax.password_check),
                                        ),
                                        validator: (String? value) {
                                          if (value!.length < 6) {
                                            return 'Please enter at least 6 characters.';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: TSizes.spaceBtwItems,),
                                      TextFormField(
                                        controller: cmfPassword,
                                        obscureText: true,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                            labelText: 'Re-type password',
                                            hintText: 'Confirm your password',
                                            prefixIcon: Icon(Iconsax.password_check),
                                        ),
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'Please re-enter password';
                                          }

                                          if (password.text != cmfPassword.text) {
                                            return "Password does not match";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: TSizes.spaceBtwItems,),
                                    ],
                                  ),
                                ),
                              )
                            ),
                            SizedBox(
                                width: 120,
                                height: 40,
                                child: ElevatedButton(onPressed: () {
                                  if(formKey.currentState?.validate() == true) {
                                    ForgetPasswordController.updatePassword(email: email, password: password.text);
                                  }
                                },
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(1),
                                        visualDensity: const VisualDensity(horizontal: 1, vertical: 1)
                                    ),
                                    child: const Text('Update'))
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

  static void stopForgetPasswordForm() {
    Navigator.of(context).pop();
  }

}