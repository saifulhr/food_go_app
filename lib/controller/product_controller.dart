import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_go_app/models/product_model.dart';
import 'package:food_go_app/services/cloudinary_service.dart';
import 'package:food_go_app/services/product_firebase_services.dart';
import 'package:food_go_app/view/product/widgets/image_picker_bottom_sheet.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController {
  final ProductServices productServices = ProductServices();

  var isloading = false.obs;
  var product = <ProductModel>[].obs;
  var selectedImage = Rx<File?>(null);
  // Firebase image Url Sent
  var uploadImageUrl = "".obs;
  // Product Controller
  final TextEditingController productNameController = TextEditingController();
  
  final TextEditingController productDescriptionController =
      TextEditingController();
  final TextEditingController productPriceController = TextEditingController();

  Future fetchProduct() async {
    try {
      isloading.value = true;
      final data = await productServices.getAllProduct();
      if (data.isNotEmpty) {
        product.assignAll(data);
      }
      isloading.value = false;
    } catch (e) {
      throw Exception("Something Went Wrong");
    }
  }

  // Cloudinary Iamge stroe Function

  Future<String?> uploadImageToCloudinary() async {
  if (selectedImage.value == null) {
    return null;
  }
  try {
    final imageUrl = await CloudinaryService.uploadImage(selectedImage.value!);
    if (imageUrl != null) {
      uploadImageUrl.value = imageUrl;
      return imageUrl;
    }
  } catch (e) {
    print("Cloudinary Upload Error $e");
    return null;
  }
}


  // Product add Function
  Future addProduct(ProductModel productModel) async {
  isloading.value = true;

  await productServices.createProduct(productModel);

  Get.snackbar(
    "Success",
    "Product Created Successfully",
    backgroundColor: Colors.green,
    colorText: Colors.white,
  );

  isloading.value = false;
  await fetchProduct();
  clearAll();
}


  // clear all feild
  clearAll() {
  productNameController.clear();
  productPriceController.clear();
  productDescriptionController.clear();
  uploadImageUrl.value = "";
  selectedImage.value = null;
}


  @override
  void onInit() {
    super.onInit();
    fetchProduct();
  }

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

  // Image Picker BottomSheet
  void showImagePickerBottomSheet() {
  Get.bottomSheet(
    ImagePickerBottomSheet(
      onImageSelected: (ImageSource source) {
        pickerImage(source); // This is ProductController's method
      },
    ),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
  );
}

  // Remove the container image logic
  void removeSelectedImage() {
    selectedImage.value = null;
  }
}
