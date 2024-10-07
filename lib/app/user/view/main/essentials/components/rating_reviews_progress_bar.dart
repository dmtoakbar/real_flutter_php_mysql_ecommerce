import 'package:flutter/material.dart';
import '../../../../../../share/constants/colors.dart';

class RatingReviewProgressBar extends StatelessWidget {
  const RatingReviewProgressBar({
    super.key,
    required this.text,
    required this.value
  });
  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(text)
        ),
        Expanded(
            flex: 11,
            child: LinearProgressIndicator(
              value: value,
              minHeight: 11,
              backgroundColor: TColors.grey,
              valueColor: const AlwaysStoppedAnimation(Colors.blue),
              borderRadius: BorderRadius.circular(7),
            )
        )
      ],
    );
  }
}