import 'package:flutter/material.dart';
import 'package:food_go_app/controller/cart_controller.dart';
import 'package:food_go_app/models/cart_model.dart';

class IncDicRemoveItems extends StatelessWidget {
  const IncDicRemoveItems({
    super.key,
    required this.item,
    required this.controller,
  });

  final CartModel item;
  final CartController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle,
                  color: Colors.red),
              onPressed: () {
                if (item.quantity! > 1) {
                  controller.decrementQuantity(item);
                }
              },
            ),
            Text(
              "${item.quantity}",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle,
                  color: Colors.green),
              onPressed: () {
                controller.incrementQuantity(item);
              },
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            controller.remove(item);
          },
        ),
      ],
    );
  }
}
