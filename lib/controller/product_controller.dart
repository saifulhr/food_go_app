import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_go_app/models/product_model.dart';
import 'package:food_go_app/services/cloudinary_service.dart';
import 'package:food_go_app/services/product_firebase_services.dart';
import 'package:food_go_app/view/product_screen/widgets/image_picker_bottom_sheet.dart';
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
  final TextEditingController productImageController = TextEditingController();
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

  // Product add Function
  Future addProduct(ProductModel productModel) async {
    isloading.value = true;
    var serviceImageUrl= await CloudinaryService.uploadImage(selectedImage.value!);
    uploadImageUrl.value = serviceImageUrl!;
    await productServices.createProduct(productModel);
    Get.snackbar(
      "Success",
      "Product Create Successfully",
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
    productImageController.clear();
    productDescriptionController.clear();
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
      const ImagePickerBottomSheet(),
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
