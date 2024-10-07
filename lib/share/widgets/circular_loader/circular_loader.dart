import 'package:flutter/material.dart';
import '../../global_variable/global_variable.dart';

class CustomCircularLoader {
  static final context = NavigationService.navigatorKey.currentContext!;

  static void showCustomCircularLoader() {
     showDialog(
         context: context,
         barrierDismissible: false,
         builder: (_) => const PopScope(
            canPop: false,
             child: Center(
               child: CircularProgressIndicator(
                 color: Colors.blue,
               ),
             )
         )
     );
  }

}