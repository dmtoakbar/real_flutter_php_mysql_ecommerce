import 'package:internet_connection_checker/internet_connection_checker.dart';

class CheckInternetConnection {

  static Future<bool> internetConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
     return true;
    } else {
      return false;
    }
  }

}