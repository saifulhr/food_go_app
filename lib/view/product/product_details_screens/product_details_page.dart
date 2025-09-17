import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_go_app/controller/cart_controller.dart';
import 'package:food_go_app/models/product_model.dart';
import 'package:food_go_app/theme/all_images.dart';
import 'package:food_go_app/view/cart/cart_screen.dart';
import 'package:food_go_app/view/product/product_details_screens/screens/product_bottom_nav_bar.dart';
import 'package:food_go_app/view/product/product_details_screens/screens/product_image.dart';
import 'package:food_go_app/view/product/product_details_screens/screens/product_name_reating_description.dart';
import 'package:food_go_app/view/product/product_details_screens/screens/product_spicy_section.dart';
import 'package:food_go_app/view/product/product_details_screens/widgets/custom_product_butoon.dart';
import 'package:get/get.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final CartController cartController = Get.find<CartController>();

  int number = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      backgroundColor: Colors.white,
      //App Bar with Left Arrow
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 37,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: SvgPicture.asset(
                AllImages.leftarowIcon,
                width: 36,
                height: 36,
              ),
            ),
          ),
          actions: [
            Obx(
              () => Stack(
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => CartScreen(),
                        transition: Transition.noTransition,
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.shopping_cart_outlined, size: 27),
                    ),
                  ),
                  //Cart Value Position
                  Positioned(
                    right: 4,
                    top: -13,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                      ),
                      child: Text(
                        '${cartController.totalItems.value}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      //Body content
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ProductImage(product: product),
            const SizedBox(height: 20),
            // Product Title
            ProductNameReatingDescription(product: product),
            const SizedBox(height: 24),
            // Spicy & Portion Sections
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Spicy Level
                const ProductSpicySection(),
                const SizedBox(width: 40),
                // Portion Selector
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Portion',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomProductButoon(
                            color: const Color(0xffEF2A39),
                            icon: Icons.remove,
                            onTap: () {
                              setState(() {
                                if (number > 1) number--;
                              });
                            },
                          ),
                          const SizedBox(width: 16),
                          Text(
                            number.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff3C2F2F),
                            ),
                          ),
                          const SizedBox(width: 16),
                          CustomProductButoon(
                            color: const Color(0xffEF2A39),
                            icon: Icons.add,
                            onTap: () {
                              setState(() {
                                number++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: ProductBottomNavBar(
        product: product,
        quantity: number,
      ),
    );
  }
}
