import 'package:flutter/material.dart';
import 'package:food_go_app/models/product_model.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[100],
        ),
        clipBehavior: Clip.antiAlias,
        child: product.images != null && product.images!.isNotEmpty
            ? Image.network(
                product.images!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.fastfood, size: 60, color: Colors.grey),
                ),
              )
            : const Center(
                child: Icon(Icons.fastfood, size: 60, color: Colors.grey),
              ),
      ),
    );
  }
}
