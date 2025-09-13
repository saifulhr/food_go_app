import 'package:flutter/material.dart';
import 'package:food_go_app/theme/all_images.dart';
import 'package:food_go_app/view/home_screen/custom_product_card.dart';
import 'package:get/get.dart';
import 'package:food_go_app/controller/product_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isloading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Subtitle
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
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),

                    // Profile Section
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

                const SizedBox(height: 30),

                // Search Bar & Notification Icon
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(2, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              AllImages.searchIcon,
                              width: 18,
                              height: 18,
                            ),
                            const SizedBox(width: 15),
                            const Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search",
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Image.asset(AllImages.dropIcon, height: 50, width: 50),
                  ],
                ),

                const SizedBox(height: 40),

                // Show either product grid or "No product" message
                Expanded(
                  child: controller.product.isEmpty
                      ? const Center(child: Text("No products found"))
                      : CustomProductCard(controller: controller,products: controller.product,),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
