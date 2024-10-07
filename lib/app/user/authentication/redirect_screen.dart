import 'package:ecom/share/route/route_names.dart';
import 'package:ecom/share/route/routes.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../share/global_variable/global_variable.dart';

class RedirectScreen {
  static final context = NavigationService.navigatorKey.currentContext!;

  static forwardScreen(String route){
    CustomRoute.replace(context, route);
  }

  static nativeSplashRemove(){
    FlutterNativeSplash.remove();
  }

  static checkUserStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isIntroShown = pref.getBool('isIntroShown') ?? false;
    bool isUserLogged = pref.getBool('isUserLogged') ?? false;
    String? userType = pref.getString('userType');
    if(isIntroShown) {
      if(isUserLogged) {
       forwardScreen(TRouteNames.userBottomNavigation);
      } else {
        forwardScreen(TRouteNames.login);
      }
    }
  }

  static setLoginStatus({required String email}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('isUserLogged', true);
    pref.setString('email', email);
  }

}