import 'package:flutter/material.dart';
import 'package:food_go_app/models/product_model.dart';

class CardImage extends StatelessWidget {
  const CardImage({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: product.images != null && product.images!.isNotEmpty
          ? Image.network(
              product.images!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Center(child: Icon(Icons.broken_image)),
            )
          : const Center(child: Icon(Icons.broken_image)),
    );
  }
}
