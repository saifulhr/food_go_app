import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_go_app/models/cart_model.dart';

class CartServices {
  final CollectionReference cartCollection = FirebaseFirestore.instance
      .collection("carts");
//Add To Carts Function
  Future<bool?> addTocart(CartModel cartmodel) async {
    try {
      await cartCollection.add(cartmodel.toJson());
      return true;
    } catch (e) {
      print(e.toString());
    }
  }
// Get Card Function
  Future<List<CartModel>?> getCart() async {
    try {
      QuerySnapshot snap = await cartCollection
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      return snap.docs
          .map((d) => CartModel.fromJson(d.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Update quantity

  Future<void> updateQuantity(String cartId, int newQuantity) async {
    await cartCollection.doc(cartId).update({"quantity": newQuantity});
  }

  // Delete Item cart

  Future deleteItemCart(String cartId) async {
    await cartCollection.doc(cartId).delete();
  }

  Future clearCart(String documentId) async {
    final snapshot = await cartCollection
        .where("userId", isEqualTo: documentId)
        .get();

    for (var document in snapshot.docs) {
      await cartCollection.doc(document.id).delete();
    }
  }
}