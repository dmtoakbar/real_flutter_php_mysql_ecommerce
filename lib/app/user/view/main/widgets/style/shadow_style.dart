import 'package:ecom/share/constants/colors.dart';
import 'package:flutter/material.dart';

class TShadowStyle {
  static BoxShadow cardShadow = BoxShadow(
       color: TColors.darkerGrey.withOpacity(0.1),
        blurRadius: 50,
        spreadRadius: 7,
        offset: const Offset(0, 2)
  );
}
