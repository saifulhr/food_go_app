import 'package:flutter/material.dart';
import 'package:food_go_app/controller/product_controller.dart';
import 'package:food_go_app/view/home_screen/widgets/card_deatils.dart';
import 'package:food_go_app/view/home_screen/widgets/card_image.dart';
import 'package:food_go_app/view/home_screen/widgets/reating_favurite.dart';

class CustomProductCard extends StatelessWidget {
  const CustomProductCard({super.key, required this.controller});

  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: controller.product.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {
        final product = controller.product[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: AspectRatio(
                  aspectRatio: 1.2,
                  child: CardImage(
                    product: product,
                  ), //Card image Sizes & Others
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CardDetails(product: product), //card details
                      SizedBox(height: 4),
                      ReatingFavourite(), // Reating and favorite
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
