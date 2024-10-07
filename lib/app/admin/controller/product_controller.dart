import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecom/app/admin/model/product_model.dart';
import 'package:ecom/share/route/route_names.dart';
import 'package:image_picker/image_picker.dart';

import '../../../helper/api_handller.dart';
import '../../../share/constants/api_constant.dart';
import '../../../share/global_variable/global_variable.dart';
import '../../../share/network/internet_connection.dart';
import '../../../share/route/routes.dart';
import '../../../share/widgets/loaders/full_screen_loader.dart';
import '../../../share/widgets/snackbar/snackbar.dart';

class AdminProductController {
  static final context = NavigationService.navigatorKey.currentContext!;

  static redirectScreen({required String routeName}) {
    CustomRoute.launch(context, routeName);
  }

  // add product
  static addProduct(
      {required String cat,
      required String name,
      required String price,
      required String description,
      required XFile? image}) async {
    var formData = FormData.fromMap({
      "cat": cat,
      "name": name,
      "price": price,
      "description": description,
      "file": await MultipartFile.fromFile(image!.path, filename: image.name),
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
      final response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL + ApiEndPoints.addProduct, data: formData);
      final value = jsonDecode(response.data);
      // check different condition
      if (value != null) {
        final int status = value['status'];
        final String message = value['message'];
        if (status == 1) {
          TFullScreenLoader.stopLoading();
          CustomSnackbar.successSnackbar(message: message);
          redirectScreen(routeName: TRouteNames.adminProductPage);
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

  // get product
  static Future<List<ProductModel>> getProduct() async {
    try {
      var response = await GetDio.getDio()
          .get(ApiEndPoints.baseURL + ApiEndPoints.getProduct);
      return productModelFromJson(response.data);
    } catch (e) {
      CustomSnackbar.errorSnackbar(message: "Something went wrong...");
      return <ProductModel>[];
    }
  }

  // edit product
  static editProduct(
      {
        required XFile? image,
        required String name,
        required String id,
        required String price,
        required String description
      }) async {
    var formData = FormData.fromMap({
      "file": image != null
          ? await MultipartFile.fromFile(image!.path, filename: image.name)
          : null,
      "name": name,
      "id": id,
      "price": price,
      "description": description
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
          ApiEndPoints.baseURL + ApiEndPoints.editProduct,
          data: formData);
      final value = jsonDecode(response.data);
      // check different condition
      if (value != null) {
        final int status = value['status'];
        final String message = value['message'];
        if (status == 1) {
          TFullScreenLoader.stopLoading();
          CustomSnackbar.successSnackbar(message: message);
          redirectScreen(routeName: TRouteNames.adminProductPage);
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


  // delete product
  static deleteProduct({required String id}) async {
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
          ApiEndPoints.baseURL + ApiEndPoints.deleteProduct,
          data: formData);
      final value = jsonDecode(response.data);
      // check different condition
      if (value != null) {
        final int status = value['status'];
        final String message = value['message'];
        if (status == 1) {
          TFullScreenLoader.stopLoading();
          CustomSnackbar.successSnackbar(message: message);
          redirectScreen(routeName: TRouteNames.adminProductPage);
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

