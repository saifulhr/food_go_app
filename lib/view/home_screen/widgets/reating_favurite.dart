import 'package:flutter/material.dart';
import 'package:food_go_app/theme/all_images.dart';

class ReatingFavourite extends StatelessWidget {
  const ReatingFavourite({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          AllImages.reatingIcon,
          height: 14,
          width: 14,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 4),
        Text(
          '4.9',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Image.asset(
          AllImages.favouriteIcon,
          width: 18,
          height: 18,
          fit: BoxFit.cover,
          color: Colors.grey,
        ),
      ],
    );
  }
}
