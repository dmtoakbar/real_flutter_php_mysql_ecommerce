import 'package:ecom/share/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../global_variable/global_variable.dart';

class CustomBottomSheet {
  static final context = NavigationService.navigatorKey.currentContext!;

  static void showCustomBottomSheet({required Widget widget}) {
    showModalBottomSheet(
        context: context,
        showDragHandle: false,
        backgroundColor: Colors.transparent,
        builder: (_) => Container(
              margin: const EdgeInsets.symmetric(horizontal: TSizes.md),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15))),
              width: MediaQuery.of(context).size.width * .92,
              constraints: BoxConstraints(
                  minHeight: 300,
                  maxHeight: MediaQuery.of(context).size.height * .8),
              padding: const EdgeInsets.all(TSizes.sm),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        transform: Matrix4.translationValues(4, -4, 0),
                        child: GestureDetector(
                            onTap: () { Navigator.of(context).pop(); },
                            child:  const Icon(Icons.clear, size: 25,)
                        ),
                      )
                    ],
                  ),
                  widget,
                  const Spacer(),
                  ElevatedButton(onPressed: () {}, child: const Text('Close'))
                ],
              ),
            ));
  }
}
