import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecom/app/admin/model/slider_model.dart';
import 'package:ecom/share/widgets/loaders/full_screen_loader.dart';
import 'package:ecom/share/widgets/snackbar/snackbar.dart';
import 'package:image_picker/image_picker.dart';

import '../../../helper/api_handller.dart';
import '../../../share/constants/api_constant.dart';
import '../../../share/global_variable/global_variable.dart';
import '../../../share/network/internet_connection.dart';
import '../../../share/route/route_names.dart';
import '../../../share/route/routes.dart';

class AdminSliderController {
  static final context = NavigationService.navigatorKey.currentContext!;

  static redirectScreen({required String routeName}) {
    CustomRoute.launch(context, routeName);
  }

  // add slider
 static addSlider({required XFile image, required String cat}) async {

    var formData = FormData.fromMap({
      "cat": cat,
       "file": await MultipartFile.fromFile(image.path, filename: image.name)
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
          .post(ApiEndPoints.baseURL + ApiEndPoints.addSlider, data: formData);
      final value = jsonDecode(response.data);
      // check different condition
      if (value != null) {
        final int status = value['status'];
        final String message = value['message'];
        if (status == 1) {
          TFullScreenLoader.stopLoading();
          CustomSnackbar.successSnackbar(message: message);
          redirectScreen(routeName: TRouteNames.adminSliderPage);
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
      CustomSnackbar.errorSnackbar(message: "Something went wrong, Please try again..");
    }
 }

 // get slider
static Future<List<SliderModel>> getSlider() async {
    try {
      var response = await GetDio.getDio().get(ApiEndPoints.baseURL + ApiEndPoints.getSlider);
      return sliderModelFromJson(response.data);
    } catch (e) {
      CustomSnackbar.errorSnackbar(message: "Something went wrong...");
      return <SliderModel>[];
    }
}


  // delete slider
  static deleteSlider({required String id}) async {
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
          ApiEndPoints.baseURL + ApiEndPoints.deleteSlider,
          data: formData);
      final value = jsonDecode(response.data);
      // check different condition
      if (value != null) {
        final int status = value['status'];
        final String message = value['message'];
        if (status == 1) {
          TFullScreenLoader.stopLoading();
          CustomSnackbar.successSnackbar(message: message);
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