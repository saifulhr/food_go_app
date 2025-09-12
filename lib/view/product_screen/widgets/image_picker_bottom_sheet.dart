import 'package:flutter/material.dart';
import 'package:food_go_app/controller/product_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerBottomSheet extends GetView<ProductController> {
  const ImagePickerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProductController());

    return Container(
      height: 170,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Wrap( 
        runSpacing: 6,
        children: [
          Center(
            child: Container(
              width: 80,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Take a Photo'),
            onTap: () {
              controller.pickerImage(ImageSource.camera);
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Choose from Gallery'),
            onTap: () {
              controller.pickerImage(ImageSource.gallery);
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
