import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go_app/models/cart_model.dart';
import 'package:food_go_app/models/order_model.dart';
import 'package:food_go_app/models/product_model.dart';
import 'package:food_go_app/services/cart_services.dart';
import 'package:food_go_app/services/order_services.dart';
import 'package:food_go_app/view/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CartController extends GetxController {
  CartServices cartServices = CartServices();
  //Order Services
  OrderServices orderServices = OrderServices();
  //Cart Items
  var cartItems = <CartModel>[].obs;
  //Total Amount
  RxDouble totalAmount = 0.0.obs;
  //Total Items
  RxInt totalItems = 0.obs;
  // Cart Loading
  var isLoading = false.obs;

  var uuid = Uuid();
  // Fint Id User
  Future<String?> findDocumentId(String productId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("carts")
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("productId", isEqualTo: productId)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return snapshot.docs.first.id;
  }

  //Fetch Item Cart
  Future fetchItemcart() async {
    isLoading.value = false;
    var cartdata = await cartServices.getCart();
    cartItems.assignAll(cartdata!);
    calculatePriceTotal();
    isLoading.value = false;
  }

  //Add to Cart
  Future addTocart(ProductModel productModel, int quantity) async {
    isLoading.value = true;

    final documentId = await findDocumentId(productModel.id!);

    if (documentId != null) {
      await FirebaseFirestore.instance
          .collection("carts")
          .doc(documentId)
          .update({"quantity": FieldValue.increment(quantity)});
    } else {
      CartModel cartModel = CartModel(
        id: uuid.v4(),
        productId: productModel.id,
        productName: productModel.name,
        productIamge: productModel.images,
        productPrice: productModel.price,
        productDescription: productModel.description,
        quantity: quantity,
        userId: FirebaseAuth
            .instance
            .currentUser
            ?.uid, // Replace with actual user ID
      );

      await cartServices.addTocart(cartModel);
      //This is the Snackbar
      Get.snackbar(
        "Success",
        "Cart Item Successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      isLoading.value = false;
      await fetchItemcart();
    }
  }

  //Calculate Total Price Off Cart Total Item
  void calculatePriceTotal() {
    totalItems.value = cartItems.length;

    // totalItems.value = cartItems.fold(0, (sum, item) => sum + item.quantity!);

    totalAmount.value = cartItems.fold(
      0,
      (sum, item) => sum + (item.quantity! * int.parse(item.productPrice!)),
    );
  }

  // Cart Page Increment Quantity
  Future incrementQuantity(CartModel cart) async {
    final documentId = await findDocumentId(cart.productId!);

    await FirebaseFirestore.instance.collection("carts").doc(documentId).update(
      {"quantity": FieldValue.increment(1)},
    );

    await fetchItemcart();
  }

  // Cart Page Dincrement Quantity
  Future decrementQuantity(CartModel cart) async {
    final documentId = await findDocumentId(cart.productId!);

    await FirebaseFirestore.instance.collection("carts").doc(documentId).update(
      {"quantity": FieldValue.increment(-1)},
    );
    await fetchItemcart();
  }

  // Cart Remove
  Future remove(CartModel cart) async {
    final documentId = await findDocumentId(cart.productId!);

    await cartServices.deleteItemCart(documentId!);

    await fetchItemcart();
  }

  //Clear Cart Function
  Future clearCart() async {
    await cartServices.clearCart(FirebaseAuth.instance.currentUser!.uid);
  }

  // Order Place Function
  Future placeOrder() async {
    if (cartItems.isEmpty) {
      Get.snackbar("Error", "Cart is empty");
      return;
    }

    final newOrder = OrderModel(
      orderId: Uuid().v4(),
      userId: FirebaseAuth.instance.currentUser!.uid,
      totalAmount: totalAmount.value,
      totalItems: totalItems.value,
      items: cartItems.map((cartkeyValue) {
        return {
          "productId": cartkeyValue.productId,
          "productname": cartkeyValue.productName,
          "prouctImage": cartkeyValue.productIamge,
          "productDescription": cartkeyValue.productDescription,
          "productPrice": cartkeyValue.productPrice,
          "quantity": cartkeyValue.quantity,
        };
      }).toList(),
    );

    await orderServices.placeOrder(newOrder);

    Get.snackbar("Success", "Order Place SuccessFully");

    await clearCart();
    await fetchItemcart();

    Get.offAll(HomeScreen());
  }

  final orders = <OrderModel>[].obs;
  var isOrderLoading = false.obs;

  Future orderData() async {
    isOrderLoading.value = false;
    var orderdata = await orderServices.getOrder();
    orders.assignAll(orderdata!);
    isOrderLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    fetchItemcart();
    orderData();
  }
}
