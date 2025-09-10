import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_go_app/models/product_model.dart';

class ProductServices {
  final CollectionReference productcollection = FirebaseFirestore.instance
      .collection("products");
// product collection
  Future createProduct(ProductModel productmodel) async {
    await productcollection.add(productmodel.toJson());
  }
// product get
  Future<List<ProductModel>> getAllProduct() async {
    final snapshot = await productcollection.get();

    return snapshot.docs
        .map(
          (value) => ProductModel.fromJson(
            value.data() as Map<String, dynamic>,
            value.id,
          ),
        )
        .toList();
  }
// product update
  Future updateproduct(ProductModel productModel) async {
    await productcollection.doc(productModel.id).update(productModel.toJson());
  }
// product delte 
  Future deleteProduct(String id) async {
    await productcollection.doc(id).delete();
  }
} 