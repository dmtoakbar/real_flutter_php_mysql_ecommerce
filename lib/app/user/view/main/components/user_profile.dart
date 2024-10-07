import 'package:ecom/app/admin/category/category_admin.dart';
import 'package:ecom/app/user/controller/log_out_controller.dart';
import 'package:ecom/share/constants/sizes.dart';
import 'package:ecom/share/route/route_names.dart';
import 'package:ecom/share/route/routes.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace/2),
          child: Column(
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminCategoryPage()));
                  },
                  child: const Text('Category'),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    CustomRoute.launch(context, TRouteNames.adminProductPage);
                  },
                  child: const Text('Product'),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    CustomRoute.launch(context, TRouteNames.adminSliderPage);
                  },
                  child: const Text('Slider'),
                ),
              ),
              const SizedBox(height: 100,),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    LogOutController.userLogOut();
                  },
                  child: const Text('LogOut'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
