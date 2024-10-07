import 'package:flutter/material.dart';

import '../../../../../share/constants/sizes.dart';
import 'carousel_slider.dart';

class CarouselHomeScreen extends StatelessWidget {
  const CarouselHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(TSizes.defaultSpace/2),
      child: const Column(
        children: [
          // slider
          CustomCarouselSlider(),
          // end slider
          SizedBox(height: TSizes.spaceBtwItems/2,),
        ],
      ),
    );
  }
}