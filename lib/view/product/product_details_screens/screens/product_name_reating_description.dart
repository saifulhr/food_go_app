import 'package:flutter/material.dart';
import 'package:food_go_app/models/product_model.dart';
import 'package:food_go_app/theme/all_images.dart';

class ProductNameReatingDescription extends StatelessWidget {
  const ProductNameReatingDescription({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name ?? 'Product Name',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff3C2F2F),
          ),
        ),
        const SizedBox(height: 8),

        RichText(
          text: TextSpan(
            text: 'Price : ',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xff3C2F2F),
            ),
            children: [
              TextSpan(
                text: '${product.price ?? '0'} ',
                style: const TextStyle(color: Color(0xff3C2F2F)),
              ),
              const TextSpan(
                text: '৳',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Rating
        Row(
          children: [
            Image.asset(AllImages.reatingIcon, height: 16, width: 16),
            const SizedBox(width: 6),
            const Text(
              '4.9 - 26 mins',
              style: TextStyle(
                color: Color(0xff808080),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Product Description
        Text(
          product.description ?? 'No description available',
          style: const TextStyle(
            color: Color(0xff6A6A6A),
            fontSize: 16,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
