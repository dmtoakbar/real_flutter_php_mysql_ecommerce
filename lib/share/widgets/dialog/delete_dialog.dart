
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../global_variable/global_variable.dart';

class TDeleteDialog {
  static final context = NavigationService.navigatorKey.currentContext!;

  static void customDeleteDialog({required VoidCallback onPressed}) {
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Center(child: Text('Are you sure?, \nyou want to delete this data...!')),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 35,
                        child: ElevatedButton(
                          onPressed: onPressed,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                              padding: const EdgeInsets.all(1),
                              visualDensity: const VisualDensity(
                                  horizontal: 1, vertical: 1)
                          ),
                          child: const Text(
                            "Yes",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 35,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              side: const BorderSide(color: Colors.blue),
                              padding: const EdgeInsets.all(1),
                              visualDensity: const VisualDensity(
                                  horizontal: 1, vertical: 1),
                          ),
                          child: const Text(
                            "No",
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
