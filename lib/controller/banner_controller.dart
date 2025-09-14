import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_go_app/models/banner_model.dart';
import 'package:food_go_app/services/banner_services.dart';
import 'package:food_go_app/services/cloudinary_service.dart';
import 'package:food_go_app/view/bottom_nav_bar.dart';
import 'package:food_go_app/view/product/widgets/image_picker_bottom_sheet.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class BannerController extends GetxController {
  BannerServices bannerServices = BannerServices();

  var bannerList = <BannerModel>[].obs;
  var currentIndex = 0.obs;
  var isBannerLoading = false.obs;
  var uploadImageUrl = "".obs;
  var selectedImage = Rx<File?>(
    null,
  ); //ImagePick Selected Image (Type : File Type)

  // Image Picker Function
  Future pickerImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      print("Image Picker Error $e");
    }
  }

  // Fetch Banner

  Future fetchBanner() async {
    isBannerLoading.value = true;
    try {
      var bannerdata = await bannerServices.getAllBanner();
      bannerList.value = bannerdata;
      isBannerLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Cloudinary Banner Iamge Store Function

  Future<String?> uploadImageToCloudinary() async {
    if (selectedImage.value == null) {
      return null;
    }
    try {
      final imageUrl = await CloudinaryService.uploadImage(
        selectedImage.value!,
      );
      if (imageUrl != null) {
        uploadImageUrl.value = imageUrl;
        return imageUrl;
      }
    } catch (e) {
      print("Cloudinary Upload Error $e");
      return null;
    }
  }

  // Banner add Function
  Future createBanners() async {
    isBannerLoading.value = true;

    final imageurlFromFirebase = await uploadImageToCloudinary();
    var uuid = Uuid();
    final updatebanner = BannerModel(
      id: uuid.v4(),
      imageUrl: imageurlFromFirebase,
    );

    await bannerServices.createbanners(updatebanner);

    Get.snackbar(
      "Success",
      "Banner Create Successfully",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    isBannerLoading.value = false;
    await fetchBanner();
    Get.offAll(()=> BottomNavBar());

  }

  @override
  void onInit() {
    super.onInit();
    fetchBanner();
  }
 void showImagePickerBottomSheet() {
  Get.bottomSheet(
    ImagePickerBottomSheet(
      onImageSelected: (ImageSource source) {
        pickerImage(source);
      },
    ),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
  );
}

  void removeSelectedImage() {
    selectedImage.value = null;
  }
}
