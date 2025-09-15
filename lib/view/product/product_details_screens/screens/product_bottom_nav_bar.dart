import 'package:flutter/material.dart';
import 'package:food_go_app/controller/cart_controller.dart';
import 'package:food_go_app/models/product_model.dart';
import 'package:food_go_app/view/product/product_details_screens/widgets/custom_text_button.dart';
import 'package:get/get.dart';

class ProductBottomNavBar extends StatelessWidget {
  final ProductModel product;
  final int quantity;

  const ProductBottomNavBar({
    super.key,
    required this.product,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final CartController cartController =Get.put(CartController());

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                cartController.addTocart(product, quantity);
              },
              child: CustomTextButton(
                height: 50,
                width: 115,
                color: const Color(0xffEF2A39),
                text: const Text(
                  'Add to cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
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
