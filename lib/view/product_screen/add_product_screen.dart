import 'package:flutter/material.dart';
import 'package:food_go_app/component/widgets/custom_button.dart';
import 'package:food_go_app/component/widgets/text_fields.dart';
import 'package:food_go_app/view/home_screen/home_screen.dart';
import 'package:food_go_app/view/product_screen/widgets/image_picker_section.dart';
import 'package:food_go_app/view/product_screen/widgets/section_title.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:food_go_app/controller/product_controller.dart';
import 'package:food_go_app/models/product_model.dart';

class AddProductScreen extends GetView<ProductController> {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProductController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xfffc8089), Color(0xffef2a39)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text(
              'Create Product',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: "Upload your image here"),
            SizedBox(height: 10),
            ImagePickerSection(),
            SectionTitle(title: 'Product Name'),
            TextFields(
              hintText: "Enter product name",
              controller: controller.productNameController,
            ),
            SectionTitle(title: 'Price'),
            TextFields(
              hintText: "Enter product price",
              controller: controller.productPriceController,
            ),

            SectionTitle(title: 'Description'),
            TextFields(
              hintText: "Enter product description",
              controller: controller.productDescriptionController,
              maxLines: 2,
            ),

            const SizedBox(height: 50),

            Obx(() {
              if (controller.isloading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return CustomButton(
                  text: "Create Product",
                  onPressed: () {
                    if (controller.productNameController.text.isEmpty ||
                        controller.productImageController.text.isEmpty ||
                        controller.productPriceController.text.isEmpty ||
                        controller.productDescriptionController.text.isEmpty) {
                      Get.snackbar(
                        "Error",
                        "All fields are required!",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    final uuid = const Uuid();

                    final newProduct = ProductModel(
                      id: uuid.v4(),
                      name: controller.productNameController.text,
                      images: controller.productImageController.text,
                      description: controller.productDescriptionController.text,
                      price: controller.productPriceController.text,
                    );

                    controller.addProduct(newProduct);
                    Get.offAll(() => HomeScreen());
                  },
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
