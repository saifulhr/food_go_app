import 'package:flutter/material.dart';
import 'package:food_go_app/models/cart_model.dart';

class OrderCartContainer extends StatelessWidget {
  const OrderCartContainer({
    super.key,
    required this.item,
  });

  final CartModel item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          item.productImage ?? "",
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            width: 60,
            height: 60,
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image),
          ),
        ),
      ),
      title: Text(item.productName ?? "No name"),
      subtitle: Text("Quantity: ${item.quantity}"),
      trailing: Text(
        "৳${(double.parse(item.productPrice ?? "0") * item.quantity!).toStringAsFixed(2)}",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }
}
