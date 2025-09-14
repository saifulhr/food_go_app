//I will do the banner screen code here
import 'package:flutter/material.dart';
import 'package:food_go_app/controller/banner_controller.dart';
import 'package:food_go_app/view/product/product_details_screens/widgets/custom_text_button.dart';
import 'package:food_go_app/view/product/widgets/image_picker_section.dart';
import 'package:get/get.dart';

class FavouriteScreen extends GetView<BannerController> {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BannerController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, title: Text("Banner Page")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Obx(
                () => ImagePickerSection(
                  imageFile: controller.selectedImage.value,
                  onRemoveImage: controller.removeSelectedImage,
                  onImagePickTap: () {
                    controller.showImagePickerBottomSheet();
                  },
                ),
              ),

              SizedBox(height: 50),
              Obx(() {
                if (controller.isBannerLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                return CustomTextButton(
                  height: 50,
                  width: double.infinity,
                  color: Colors.red,
                  text: Text("Submit", style: TextStyle(color: Colors.white)),
                  ontap: () {
                    controller.createBanners();
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
