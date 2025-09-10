import 'package:flutter/material.dart';
import 'package:food_go_app/controller/product_controller.dart';
import 'package:get/get.dart';

class ImagePickerSection extends GetView<ProductController> {
  const ImagePickerSection({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProductController());

    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: Column(
        children: [
          Obx(() {
            return GestureDetector(
              onTap: () {
                controller.showImagePickerBottomSheet();
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Stack(
                  children: [
                    Container(
                      height: 190,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[200],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: controller.selectedImage.value != null
                            ? Image.file(
                                controller.selectedImage.value!,
                                fit: BoxFit.cover,
                              )
                            : Center(
                                child: Icon(
                                  Icons.add,
                                  size: 50,
                                  color: Colors.grey[700],
                                ),
                              ),
                      ),
                    ),

                    // Positioned Cross Icon Remove Button
                    if (controller.selectedImage.value != null)
                      Positioned(
                        top: 6,
                        right: 6,
                        child: GestureDetector(
                          onTap: () {
                            controller.removeSelectedImage();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
