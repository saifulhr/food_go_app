import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_go_app/models/product_model.dart';
import 'package:food_go_app/theme/all_images.dart';
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
  int number = 1;
  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      backgroundColor: Colors.white,
      //App Bar with Bigger Left Arrow
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
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
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(
                AllImages.search01Icon,
                height: 30,
                width: 30,
                fit: BoxFit.scaleDown,
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
                ProductSpicySection(),
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
            const SizedBox(height: 100), // Space for bottom bar
          ],
        ),
      ),
      //Fixed Bottom Bar for Price & Order Now
      bottomNavigationBar: ProductBottomNavBar(product: product),
    );
  }
}
