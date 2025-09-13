import 'package:flutter/material.dart';
import 'package:food_go_app/view/product_screen/product_details_screens/widgets/custom_range_slider.dart';

class ProductSpicySection extends StatelessWidget {
  const ProductSpicySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Spicy',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xffEF2A39),
            ),
          ),
          const SizedBox(height: 12),
          const CustomRangeSlider(),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Mild',
                style: TextStyle(
                  color: Color(0xff1CC019),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Hot',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xffEF2A39),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
