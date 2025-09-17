import 'package:flutter/material.dart';
import 'package:food_go_app/controller/banner_controller.dart';
import 'package:food_go_app/controller/cart_controller.dart';
import 'package:food_go_app/controller/product_controller.dart';
import 'package:food_go_app/theme/all_images.dart';
import 'package:food_go_app/view/cart/cart_screen.dart';
import 'package:food_go_app/view/home/screens/banner_slider.dart';
import 'package:food_go_app/view/home/screens/custom_product_card.dart';
import 'package:food_go_app/view/home/screens/seach_and_notification.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class HomeScreen extends GetView<ProductController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BannerController());

    final ProductController productController = Get.put(ProductController());
    final CartController cartController = Get.put(CartController()); // ✅ Name fixed

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (productController.isloading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "FoodGo",
                              style: TextStyle(
                                fontFamily: 'Lobster',
                                fontSize: 35,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Order your favourite food !",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),

                        // Cart Icon with badge
                        Padding(
                          padding: const EdgeInsets.only(top: 11.0, left: 20),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => const CartScreen(), transition: Transition.noTransition);
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                const Icon(Icons.shopping_cart_outlined, size: 35),
                                Obx(() {
                                  if (cartController.totalItems.value == 0) return const SizedBox();

                                  return Positioned(
                                    right: -6,
                                    top: -6,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        '${cartController.totalItems.value}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),

                        // Profile Image
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.asset(
                            AllImages.profileImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    // Search
                    const SearchAndNotification(),
                  ],
                ),
              ),

              // Product List & Banner
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      const BannerSlider(),
                      const SizedBox(height: 15),
                      productController.product.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text("No Products"),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: CustomProductCard(
                                controller: productController,
                                products: productController.product,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
