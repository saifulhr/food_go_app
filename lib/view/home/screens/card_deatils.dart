import 'package:flutter/material.dart';
import 'package:food_go_app/models/product_model.dart';

class CardDetails extends StatelessWidget {
  const CardDetails({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
    
        const SizedBox(height: 2),
    
        Text(
          product.description ?? '',
          style: const TextStyle(
            fontSize: 11,
            color: Colors.grey,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
    
        SizedBox(height: 6),
    
        Text(
          "৳${product.price}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
