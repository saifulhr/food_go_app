import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go_app/models/cart_model.dart';
import 'package:food_go_app/models/order_model.dart';
import 'package:food_go_app/models/product_model.dart';
import 'package:food_go_app/services/cart_services.dart';
import 'package:food_go_app/services/order_services.dart';
import 'package:food_go_app/view/bottom_nav_bar.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CartController extends GetxController {
  CartServices cartServices = CartServices();
  OrderServices orderServices = OrderServices();

  // This is Cart Items
  var cartItems = <CartModel>[].obs;

  //Cart Total Amount
  RxDouble totalAmount = 0.0.obs;

  //Total Items
  RxInt totalItems = 0.obs;

  var isLoading = false.obs;
  var isOrderLoading = false.obs;

  var uuid = Uuid();
//Cart item Find Document
  Future<String?> findDocumentId(String productId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("carts")
        .where("UserId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("ProductId", isEqualTo: productId)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return snapshot.docs.first.id;
  }
//Cart Fetch
  Future fetchItemcart() async {
    isLoading.value = true;
    var cartdata = await cartServices.getCart();
    print("Fetched Cart Items: ${cartdata?.length}");
    cartItems.assignAll(cartdata!);
    calculatePriceTotal();
    isLoading.value = false;
  }

  // ignore: non_constant_identifier_names
  Future addTocart(ProductModel productModel, int quantity) async {
    isLoading.value = true;

    final documentId = await findDocumentId(productModel.id!);

    if (documentId != null) {
      await FirebaseFirestore.instance
          .collection("carts")
          .doc(documentId)
          .update({"Quantity": FieldValue.increment(quantity)});
    } else {
      CartModel cartModel = CartModel(
        id: uuid.v4(),
        productId: productModel.id,
        productName: productModel.name,
        productImage: productModel.images,
        productPrice: productModel.price,
        productDescription: productModel.description,
        quantity: quantity,
        userId: FirebaseAuth
            .instance
            .currentUser
            ?.uid, // Replace with actual user ID
      );

      await cartServices.addTocart(cartModel);

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
//Cart Total Item Calculate Price
  void calculatePriceTotal() {
    totalItems.value = cartItems.length;

    totalAmount.value = cartItems.fold(
      0.0,
      (sum, item) =>
          sum +
          ((item.quantity ?? 0) *
              (double.tryParse(item.productPrice ?? '0') ?? 0)),
    );
  }
//Cart IncreamentQuantitay
  Future incrementQuantity(CartModel cart) async {
    final documentId = await findDocumentId(cart.productId!);

    if (documentId == null) {
      Get.snackbar("Error", "Cart item not found for increment");
      return;
    }

    await FirebaseFirestore.instance.collection("carts").doc(documentId).update(
      {"Quantity": FieldValue.increment(1)},
    );

    await fetchItemcart();
  }
//Cart decreamentQuantitay
  Future decrementQuantity(CartModel cart) async {
    if (cart.quantity == null || cart.quantity! <= 1) {
      Get.snackbar("Notice", "Minimum quantity is 1");
      return;
    }

    final documentId = await findDocumentId(cart.productId!);

    if (documentId == null) {
      Get.snackbar("Error", "Cart item not found for decrement");
      return;
    }

    await FirebaseFirestore.instance.collection("carts").doc(documentId).update(
      {"Quantity": FieldValue.increment(-1)},
    );
    await fetchItemcart();
  }
//Cart Remove
  Future remove(CartModel cart) async {
    final documentId = await findDocumentId(cart.productId!);

    if (documentId == null) {
      Get.snackbar("Error", "Cart item not found for removal");
      return;
    }

    await cartServices.deleteItemCart(documentId);

    await fetchItemcart();
  }
//Claer Cart
  Future clearCart() async {
    await cartServices.clearCart(FirebaseAuth.instance.currentUser!.uid);
  }
//Place Order 
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
          "prouctImage": cartkeyValue.productImage,
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

    Get.offAll(BottomNavBar());
  }

  final orders = <OrderModel>[].obs;
//Order Data
  Future orderData() async {
    isOrderLoading.value = true;
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
