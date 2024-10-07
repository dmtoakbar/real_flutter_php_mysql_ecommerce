import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecom/share/route/route_names.dart';
import 'package:ecom/share/route/routes.dart';
import 'package:image_picker/image_picker.dart';

import '../../../helper/api_handller.dart';
import '../../../share/constants/api_constant.dart';
import '../../../share/global_variable/global_variable.dart';
import '../../../share/network/internet_connection.dart';
import '../../../share/widgets/loaders/full_screen_loader.dart';
import '../../../share/widgets/snackbar/snackbar.dart';
import '../model/category_model.dart';

class CategoryAdminController {
  static final context = NavigationService.navigatorKey.currentContext!;

  static redirectScreen({required String routeName}) {
    CustomRoute.launch(context, routeName);
  }

  // add category
  static addImageCatAndName(
      {required XFile? image, required String name}) async {
    var formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(image!.path, filename: image.name),
      "name": name,
    });

    try {
      // full screen loader
      TFullScreenLoader.openLoadingDialog(text: "Processing request...");

      // check internet connection
      final internet = await CheckInternetConnection.internetConnection();
      if (!internet) {
        TFullScreenLoader.stopLoading();
        CustomSnackbar.errorSnackbar(message: 'No internet connection');
        return;
      }

      // send data to server
      final response = await GetDio.getDio().post(
          ApiEndPoints.baseURL + ApiEndPoints.addCategory,
          data: formData);
      final value = jsonDecode(response.data);
      // check different condition
      if (value != null) {
        final int status = value['status'];
        final String message = value['message'];
        if (status == 1) {
          TFullScreenLoader.stopLoading();
          CustomSnackbar.successSnackbar(message: message);
          redirectScreen(routeName: TRouteNames.adminCategoryPage);
        } else if (status == 2) {
          TFullScreenLoader.stopLoading();
          CustomSnackbar.errorSnackbar(message: message);
        } else {
          TFullScreenLoader.stopLoading();
          CustomSnackbar.errorSnackbar(message: message);
        }
      } else {
        TFullScreenLoader.stopLoading();
        CustomSnackbar.errorSnackbar(
            message: "Something went wrong, Please try again...");
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      CustomSnackbar.errorSnackbar(
          message: "Something went wrong, Please try again..");
    }
  }

  // get category

  static Future<List<CategoryModel>> getCategory() async {
    try {
      var response = await GetDio.getDio()
          .get(ApiEndPoints.baseURL + ApiEndPoints.getCategory);
      return categoryModelFromJson(response.data);
    } catch (e) {
      CustomSnackbar.errorSnackbar(message: "Something went wrong...");
      return <CategoryModel>[];
    }
  }

  // edit category
  static editCategory({required XFile? image, required String name, required String id}) async {
    var formData = FormData.fromMap({
      "file": image != null ? await MultipartFile.fromFile(image!.path, filename: image.name) : null,
      "name": name,
      "id": id
    });

    try {
      // full screen loader
      TFullScreenLoader.openLoadingDialog(text: "Processing request...");

      // check internet connection
      final internet = await CheckInternetConnection.internetConnection();
      if (!internet) {
        TFullScreenLoader.stopLoading();
        CustomSnackbar.errorSnackbar(message: 'No internet connection');
        return;
      }

      // send data to server
      final response = await GetDio.getDio().post(
          ApiEndPoints.baseURL + ApiEndPoints.editCategory,
          data: formData);
      final value = jsonDecode(response.data);
      // check different condition
      if (value != null) {
        final int status = value['status'];
        final String message = value['message'];
        if (status == 1) {
          TFullScreenLoader.stopLoading();
          CustomSnackbar.successSnackbar(message: message);
          redirectScreen(routeName: TRouteNames.adminCategoryPage);
        } else if (status == 2) {
          TFullScreenLoader.stopLoading();
          CustomSnackbar.errorSnackbar(message: message);
        } else {
          TFullScreenLoader.stopLoading();
          CustomSnackbar.errorSnackbar(message: message);
        }
      } else {
        TFullScreenLoader.stopLoading();
        CustomSnackbar.errorSnackbar(
            message: "Something went wrong, Please try again...");
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      CustomSnackbar.errorSnackbar(
          message: "Something went wrong, Please try again..");
    }
  }

   // delete category

 static deleteCategory({required String id}) async {
   var formData = FormData.fromMap({
   "id": id
   });

   try {
     // full screen loader
     TFullScreenLoader.openLoadingDialog(text: "Processing request...");

     // check internet connection
     final internet = await CheckInternetConnection.internetConnection();
     if (!internet) {
       TFullScreenLoader.stopLoading();
       CustomSnackbar.errorSnackbar(message: 'No internet connection');
       return;
     }

     // send data to server
     final response = await GetDio.getDio().post(
         ApiEndPoints.baseURL + ApiEndPoints.deleteCategory,
         data: formData);
     final value = jsonDecode(response.data);
     // check different condition
     if (value != null) {
       final int status = value['status'];
       final String message = value['message'];
       if (status == 1) {
         TFullScreenLoader.stopLoading();
         CustomSnackbar.successSnackbar(message: message);
         redirectScreen(routeName: TRouteNames.adminCategoryPage);
       } else {
         TFullScreenLoader.stopLoading();
         CustomSnackbar.errorSnackbar(message: message);
       }
     } else {
       TFullScreenLoader.stopLoading();
       CustomSnackbar.errorSnackbar(
           message: "Something went wrong, Please try again...");
     }
   } catch (e) {
     TFullScreenLoader.stopLoading();
     CustomSnackbar.errorSnackbar(
         message: "Something went wrong, Please try again..");
   }
 }

}
