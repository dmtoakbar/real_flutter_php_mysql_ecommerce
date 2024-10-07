
import 'package:dio/dio.dart';
import '../share/constants/api_constant.dart';
import 'dio_logger_manual.dart';

class GetDio {
  static Dio getDio({bool isMultipart = false}) {
    Dio dio = Dio();
    var options = BaseOptions();
    options.connectTimeout = const Duration(milliseconds: 900000);
    options.receiveTimeout = const Duration(milliseconds: 900000);
    options.sendTimeout = const Duration(milliseconds: 900000);
    options.followRedirects = true;
    options.validateStatus = (status) {
      return true;
    };

    options.receiveDataWhenStatusError = true;
    options.responseType = ResponseType.plain;
    options.contentType = "multipart/form-data";
    options.baseUrl = ApiEndPoints.baseURL;
    dio.options = options;

    // For create Log for api request
    dio.interceptors.add(PrettyDioLogger(
        maxWidth: 100,
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        responseBobyInJson: true
    ));
    return dio;
  }

}
