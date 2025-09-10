import 'package:flutter/material.dart';
import 'package:food_go_app/controller/product_controller.dart';
import 'package:get/get.dart';

class ProductScreen extends GetView<ProductController> {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(()=> ProductController());
    return const Placeholder();
  }
}