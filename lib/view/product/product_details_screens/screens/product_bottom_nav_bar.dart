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
    final CartController cartController = Get.put(CartController());

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() {
              return GestureDetector(
                onTap: cartController.isLoading.value
                    ? null
                    : () {
                        cartController.addTocart(product, quantity);
                      },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomTextButton(
                      height: 50,
                      width: 115,
                      color: const Color(0xffEF2A39),
                      text: Text(
                        cartController.isLoading.value ? '' : 'Add to cart',
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (cartController.isLoading.value)
                      const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      ),
                  ],
                ),
              );
            }),

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
