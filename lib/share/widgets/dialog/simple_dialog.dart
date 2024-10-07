import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../global_variable/global_variable.dart';

class TSimpleDialog {
  static final context = NavigationService.navigatorKey.currentContext!;

  static void customSimpleDialog({required Widget message}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        useSafeArea: true,
        builder: (_) => SimpleDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
              children: [
                Container(
                  height: 150,
                  width: 200,
                  constraints:
                      const BoxConstraints(maxWidth: 400, maxHeight: 500),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            transform: Matrix4.translationValues(-4, -8, 0),
                            child: GestureDetector(
                               onTap: () { Navigator.of(context).pop(); },
                                child: const Icon(Iconsax.close_square, size: 28,)
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      message,
                      const Spacer(),
                      SizedBox(
                        width: 100,
                        height: 35,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                              padding: const EdgeInsets.all(1),
                              visualDensity: const VisualDensity(
                                  horizontal: 1, vertical: 1)
                          ),
                          child: const Text(
                            "Close",
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ));
  }
}
