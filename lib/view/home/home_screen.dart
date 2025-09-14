import 'package:flutter/material.dart';
import 'package:food_go_app/controller/banner_controller.dart';
import 'package:food_go_app/theme/all_images.dart';
import 'package:food_go_app/view/home/screens/banner_slider.dart';
import 'package:food_go_app/view/home/screens/custom_product_card.dart';
import 'package:food_go_app/view/home/screens/seach_and_notification.dart';
import 'package:get/get.dart';
import 'package:food_go_app/controller/product_controller.dart';

class HomeScreen extends GetView<ProductController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BannerController());
    final ProductController controller = Get.put(ProductController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isloading.value) {
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
                    //Text and Profile
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                    // Search Bar o Notification
                    SearchAndNotification(),
                  ],
                ),
              ),

              // Scrollable Part
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),

                      // Carousel banner gulo
                      BannerSlider(),

                      const SizedBox(height: 15),

                      // Products
                      controller.product.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text("No Products"),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: CustomProductCard(
                                controller: controller,
                                products: controller.product,
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
