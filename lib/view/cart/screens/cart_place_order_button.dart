import 'package:flutter/material.dart';
import 'package:food_go_app/controller/cart_controller.dart';

class CartPLaceOrderButton extends StatelessWidget {
  const CartPLaceOrderButton({
    super.key,
    required this.controller,
  });

  final CartController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff3C2F2F),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: controller.cartItems.isEmpty
              ? null
              : () async {
                  await controller.placeOrder();
                },
          child: const Text(
            "PLACE ORDER",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
