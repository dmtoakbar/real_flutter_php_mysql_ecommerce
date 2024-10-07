import 'package:flutter/material.dart';
import '../../constants/sizes.dart';

class IntroPageViewItem extends StatelessWidget {
  const IntroPageViewItem({
    super.key, required this.image, required this.title, required this.subTitle,
  });

  final String image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image(image: AssetImage(image),),
        ),
        const SizedBox(height: TSizes.spaceBtwItems,),
        Text(title, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center,),
        const SizedBox(height: TSizes.spaceBtwItems,),
        Text(subTitle, style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,)
      ],
    );
  }
}