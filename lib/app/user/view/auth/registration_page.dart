import 'dart:convert';
import 'package:ecom/app/user/view/auth/widgets/verify_email_success.dart';
import 'package:ecom/share/constants/colors.dart';
import 'package:ecom/share/network/internet_connection.dart';
import 'package:ecom/share/route/route_names.dart';
import 'package:ecom/share/route/routes.dart';
import 'package:ecom/share/widgets/snackbar/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;

import '../../../../share/constants/api_constant.dart';
import '../../../../share/constants/image_string.dart';
import '../../../../share/constants/sizes.dart';
import '../../controller/user_auth_controller.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cmfPassword = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController name = TextEditingController();

  bool passwordHide = true;
  bool passwordHideC = true;
  bool checkBoxStatus = false;
  String email1 = "", password1 = "";
  final formKey = GlobalKey<FormState>();
  bool? formIsValid;
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    cmfPassword.dispose();
    code.dispose();
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              right: TSizes.defaultSpace,
              left: TSizes.defaultSpace,
              bottom: TSizes.defaultSpace,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Image(image: AssetImage(TImages.splashImage), height: 80,),
                    const SizedBox(height: TSizes.spaceBtwItems/2,),
                    Text(
                      'Glad to meet you', style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems/2,),
                    Text(
                      'Create your new account for future uses', style: Theme.of(context).textTheme.titleSmall,
                    )
                  ],
                ),
                // login form
                const SizedBox(height: TSizes.spaceBtwSections,),
                Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: name,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter your name',
                          prefixIcon: Icon(Iconsax.user),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems,),
                      TextFormField(
                        controller: email,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          prefixIcon: Icon(Icons.email),
                        ),
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
                        onSaved: (String? value) {
                          email1 = value!;
                        },
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems,),
                      TextFormField(
                        controller: password,
                        obscureText: passwordHide ? true : false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            prefixIcon: const Icon(Iconsax.password_check),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  passwordHide = !passwordHide;
                                });
                              },
                              child: Icon(passwordHide ? Iconsax.eye_slash : Iconsax.eye),
                            )
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
                        obscureText: passwordHideC ? true : false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Re-type password',
                            hintText: 'Confirm your password',
                            prefixIcon: const Icon(Iconsax.password_check),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  passwordHideC = !passwordHideC;
                                });
                              },
                              child: Icon(passwordHideC ? Iconsax.eye_slash : Iconsax.eye),
                            )
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
                      TextFormField(
                        textCapitalization: TextCapitalization.characters,
                        keyboardType: TextInputType.text,
                        controller: code,
                        decoration: const InputDecoration(
                          labelText: 'Refer code',
                          hintText: 'Enter refer code',
                          prefixIcon: Icon(Icons.text_fields),
                        ),
                          validator: (String? value) {
                            return null;
                          }
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems,),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(value: checkBoxStatus, onChanged: (value) {
                        setState(() {
                          checkBoxStatus = !checkBoxStatus;
                        });
                      }),
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems/2,),
                    Flexible(
                      child: Text.rich(TextSpan(
                        children: [
                          TextSpan(
                            text: 'Are you agree ',
                            style: Theme.of(context).textTheme.bodySmall
                          ),
                          TextSpan(
                            text: 'Nexus shop terms ',
                            style: Theme.of(context).textTheme.bodySmall!.apply(
                              color: TColors.primary,
                               decoration: TextDecoration.underline,
                               decorationColor: TColors.primary
                            )
                          ),
                          TextSpan(
                              text: 'And ',
                              style: Theme.of(context).textTheme.bodySmall
                          ),
                          TextSpan(
                              text: 'Nexus shop Privacy Policy',
                              style: Theme.of(context).textTheme.bodySmall!.apply(
                                  color: TColors.primary,
                                  decoration: TextDecoration.underline,
                                  decorationColor: TColors.primary
                              )
                          ),
                        ]
                      )),
                    )
                  ],
                ),

                const SizedBox(height: TSizes.spaceBtwItems,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        formIsValid = formKey.currentState?.validate();
                      });

                      if(formKey.currentState!.validate() == true) {
                        // --------------- term and condition check --------------------//
                        if(!checkBoxStatus) {
                          CustomSnackbar.errorSnackbar(message: "Please check terms and privacy policy of nexus shop to create account and use services.");
                        }
                        // ---------------- end terms and condition check --------------//
                        if(checkBoxStatus) {

                          //------------------- register
                          if (formKey.currentState?.validate() == true) {
                            await UserAuthController.userRegister(
                                name: name.text,
                                email: email.text,
                                password: password.text,
                                code: code.text);
                          }
                          // end register

                        }


                      }

                    },
                    child: const Text('Register'),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account:', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.grey), ),
                    TextButton(onPressed: (){
                      CustomRoute.replace(context, TRouteNames.login);
                    }, child: const Row(
                      children: [
                        Text('Login', style: TextStyle(fontSize: 16),),
                        Icon(Iconsax.arrow_right_4,)
                      ],
                    ))
                  ],
                )



              ],
            ),
          ),
        ),
      ),
    );
  }



  // registration function
  Future registerUser() async {
    var url = ApiEndPoints.baseURL + ApiEndPoints.userRegister;
    Map postData = {
      'name' : name.text,
      'email': email.text,
      'password': password.text,
      'code': code.text,
    };
    print(postData);
    var response = await http.post(Uri.parse(url), body: postData);
    var data = jsonDecode(response.body);
    code.clear();
    email.clear();
    password.clear();
    name.clear();
    cmfPassword.clear();

    print(data);
  }
}
