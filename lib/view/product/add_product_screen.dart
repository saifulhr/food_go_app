import 'package:flutter/material.dart';
import 'package:food_go_app/component/widgets/custom_button.dart';
import 'package:food_go_app/component/widgets/text_fields.dart';
import 'package:food_go_app/view/bottom_nav_bar.dart';
import 'package:food_go_app/view/product/widgets/image_picker_section.dart';
import 'package:food_go_app/view/product/widgets/section_title.dart';
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
            Obx(
              () => ImagePickerSection(
                imageFile: controller.selectedImage.value,
                onRemoveImage: controller.removeSelectedImage,
                onImagePickTap: () {
                  controller.showImagePickerBottomSheet();
                },
              ),
            ),

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
              maxLines: 4,
            ),

            const SizedBox(height: 30),

            Obx(() {
              if (controller.isloading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return CustomButton(
                  text: "Create Product",
                  onPressed: () async {
                    if (controller.productNameController.text.trim().isEmpty ||
                        controller.selectedImage.value == null ||
                        controller.productPriceController.text.trim().isEmpty ||
                        controller.productDescriptionController.text
                            .trim()
                            .isEmpty) {
                      Get.snackbar(
                        "Error",
                        "All fields are required!",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    controller.isloading.value = true;

                    String? imageUrl = await controller
                        .uploadImageToCloudinary();

                    if (imageUrl == null) {
                      controller.isloading.value = false;
                      Get.snackbar(
                        "Error",
                        "Image upload failed!",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    final newProduct = ProductModel(
                      id: Uuid().v4(),
                      name: controller.productNameController.text,
                      images: imageUrl,
                      description: controller.productDescriptionController.text,
                      price: controller.productPriceController.text,
                    );

                    await controller.addProduct(newProduct);

                    controller.isloading.value = false;

                    Get.offAll(() => BottomNavBar());
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
