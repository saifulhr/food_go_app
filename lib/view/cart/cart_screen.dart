import 'package:flutter/material.dart';
import 'package:food_go_app/controller/cart_controller.dart';
import 'package:get/get.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CartController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Cart Screen',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
          ),
        ),
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return Center(child: Text("Your cart is empty"));
        }

        return ListView.builder(
          itemCount: controller.cartItems.length,
          itemBuilder: (context, index) {
            var data = controller.cartItems[index];
            return Padding(
              padding: EdgeInsets.all(10),
              child: Card(
                elevation: 0,
                child: ListTile(
                  title: Text("${data.productName}"),
                  subtitle: Text('Quantity: ${data.quantity}'),
                  trailing: Text('\$${data.productPrice}'),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
