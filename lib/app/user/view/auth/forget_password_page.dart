
import 'package:ecom/app/user/controller/forget_password_controller.dart';
import 'package:ecom/app/user/view/auth/widgets/forget_password_form.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../share/constants/image_string.dart';
import '../../../../share/constants/sizes.dart';
import '../../../../share/route/route_names.dart';
import '../../../../share/route/routes.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController email = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool? isFormValid;

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: TSizes.spaceBtwSections/2,),
                    const Image(image: AssetImage(TImages.splashImage), height: 80,),
                    const SizedBox(height: TSizes.spaceBtwItems/2,),
                    Text(
                      'Forget your password', style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems/2,),
                    Text(
                      'Create your new password for future uses.', style: Theme.of(context).textTheme.titleSmall,
                    )
                  ],
                ),
                // login form
                const SizedBox(height: TSizes.spaceBtwSections,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      autovalidateMode: AutovalidateMode.disabled,
                      key: formKey,
                      child: TextFormField(
                        controller: email,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Email';
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return 'Please a valid Email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems,),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isFormValid = formKey.currentState?.validate();
                      });

                      if(formKey.currentState!.validate() == true) {
                        ForgetPasswordController.forgetPassword(email: email.text);
                      }

                    },
                    child: const Text('Forget Password'),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('You can Login:', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.grey), ),
                    TextButton(onPressed: (){
                      CustomRoute.replace(context, TRouteNames.login);
                    }, child: const Row(
                      children: [
                        Text('Login', style: TextStyle(fontSize: 16),),
                        Icon(Iconsax.arrow_right_4,)
                      ],
                    ))
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
