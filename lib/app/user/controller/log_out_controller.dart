import 'package:ecom/share/route/route_names.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../share/global_variable/global_variable.dart';
import '../../../share/route/routes.dart';

class LogOutController {
  static final context = NavigationService.navigatorKey.currentContext!;

  static forwardScreen(String route){
    CustomRoute.replace(context, route);
  }

  static userLogOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('isUserLogged', false);
    pref.remove('email');
    forwardScreen(TRouteNames.login);
  }

}