import 'package:flutter/material.dart';
import 'package:food_go_app/controller/product_controller.dart';
import 'package:food_go_app/models/product_model.dart';
import 'package:food_go_app/view/home/screens/card_deatils.dart';
import 'package:food_go_app/view/home/screens/card_image.dart';
import 'package:food_go_app/view/home/screens/reating_favurite.dart';
import 'package:food_go_app/view/product/product_details_screens/product_details_page.dart';
import 'package:get/get.dart';

class CustomProductCard extends StatelessWidget {
  final List<ProductModel> products;
  const CustomProductCard({super.key, required this.controller, required this.products});

  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: 0.60,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
        onTap: () {
          Get.to(() => ProductDetailsPage(product: product));
        },
          child: Container(
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
          ),
        );
      },
    );
  }
}
