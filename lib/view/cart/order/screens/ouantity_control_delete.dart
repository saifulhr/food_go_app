import 'package:flutter/material.dart';
import 'package:food_go_app/controller/cart_controller.dart';
import 'package:food_go_app/models/cart_model.dart';

class OuantityControlDelete extends StatelessWidget {
  const OuantityControlDelete({
    super.key,
    required this.item,
    required this.controller,
  });

  final CartModel item;
  final CartController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  if (item.quantity! > 1) {
                    controller.decrementQuantity(item);
                  }
                },
                icon: const Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
              ),
              Text(
                "${item.quantity}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  controller.incrementQuantity(item);
                },
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              controller.remove(item);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
