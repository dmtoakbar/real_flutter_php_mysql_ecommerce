import 'package:ecom/app/user/authentication/set_user_login_for_future.dart';
import 'package:ecom/app/user/controller/sign_in_controller.dart';
import 'package:ecom/share/constants/image_string.dart';
import 'package:ecom/share/constants/sizes.dart';
import 'package:ecom/share/route/route_names.dart';
import 'package:ecom/share/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class WelcomeBackPage extends StatefulWidget {
  const WelcomeBackPage({super.key});

  @override
  State<WelcomeBackPage> createState() => _WelcomeBackPageState();
}

class _WelcomeBackPageState extends State<WelcomeBackPage> {
  bool passwordHide = true;
  bool checkBoxStatus = false;

  final formKey = GlobalKey<FormState>();

  var controller = SetUserLoginDataForFuture();
  @override
  void initState() {
    controller.setLastUserLoginEmail();
    controller.setLastUserLoginPassword();
    super.initState();
  }


  @override
  void dispose() {
    //email.dispose();
    //password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController email = controller.email;
    TextEditingController password = controller.password;
    return Scaffold(
      backgroundColor: Colors.white,
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
                      'Welcome Back', style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems/2,),
                    Text(
                      'Discover limitless choices and unmatched convenience', style: Theme.of(context).textTheme.titleSmall,
                    )
                  ],
                ),
                // login form
                const SizedBox(height: TSizes.spaceBtwSections,),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.disabled,
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
                        }
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems,),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.disabled,
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
                          if(value!.isEmpty) {
                            return 'Please Enter Password..';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems,),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                        const SizedBox(width: TSizes.sm/2,),
                        const Text('Remember me', style: TextStyle(fontSize: 12),)
                      ],
                    ),
                    const Spacer(),
                    TextButton(onPressed: () {
                      CustomRoute.launch(context, TRouteNames.forgetPassword);
                    }, child: const Text('Forget Password'))
                  ],
                ),

                const SizedBox(height: TSizes.spaceBtwItems,),
                SizedBox(
                 width: double.infinity,
                 child: ElevatedButton(
                   onPressed: () {
                     if(formKey.currentState?.validate() == true) {
                        SingInController.signIn(email: email.text, password: password.text, rememberMe: checkBoxStatus);
                     }
                   },
                   child: const Text('Login'),
                 ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('New User Register:', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.grey), ),
                    TextButton(onPressed: (){
                     CustomRoute.launch(context, TRouteNames.register);
                    }, child: const Row(
                      children: [
                      Text('Register', style: TextStyle(fontSize: 16),),
                        Icon(Iconsax.arrow_right_4,)
                      ],
                    ))
                  ],
                ),

                const SizedBox(height: TSizes.spaceBtwSections/2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Home:', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.grey), ),
                    TextButton(onPressed: (){
                       CustomRoute.launch(context, TRouteNames.userBottomNavigation);
                    }, child: const Row(
                      children: [
                        Text('Home', style: TextStyle(fontSize: 16),),
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
}
