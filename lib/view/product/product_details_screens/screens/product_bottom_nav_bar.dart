import 'package:flutter/material.dart';
import 'package:food_go_app/models/product_model.dart';
import 'package:food_go_app/view/product/product_details_screens/widgets/custom_text_button.dart';

class ProductBottomNavBar extends StatelessWidget {
  const ProductBottomNavBar({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextButton(
              height: 50,
              width: 100,
              color: const Color(0xffEF2A39),
              text: Text(
                '\$${product.price ?? '0.00'}',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            CustomTextButton(
              height: 50,
              width: 180,
              color: const Color(0xff3C2F2F),
              text: const Text(
                'ORDER NOW',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
