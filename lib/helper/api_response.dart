import 'package:http/http.dart';

class ApiResponse {
  final Response? response;
  final int statusCode;

  ApiResponse({this.response, required this.statusCode});
}