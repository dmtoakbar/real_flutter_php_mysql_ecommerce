import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class PageViewPointIndicator extends StatelessWidget {
  const PageViewPointIndicator({
    super.key, required this.pageIndex, required this.pageNo,
  });
  final int pageIndex;
  final int pageNo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(TSizes.sm),
      width: 12,
      height: 12,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 2),
          color:  pageIndex == pageNo ? TColors.primary : Colors.white),
    );
  }
}