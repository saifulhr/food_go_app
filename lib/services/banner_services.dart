import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_go_app/models/banner_model.dart';

class BannerServices {
  final CollectionReference productcollection = FirebaseFirestore.instance
      .collection("banners");
  // Banner collection
  Future createbanners(BannerModel productmodel) async {
    await productcollection.add(productmodel.toJson());
  }

  // Banner get
  Future<List<BannerModel>> getAllBanner() async {
    final snapshot = await productcollection.get();

    return snapshot.docs
        .map(
          (value) => BannerModel.fromJson(value.data() as Map<String, dynamic>),
        )
        .toList();
  }

  // Banner update
  Future updateBanner(BannerModel productModel) async {
    await productcollection.doc(productModel.id).update(productModel.toJson());
  }

  // Banner delete
  Future deleteBanner(String id) async {
    await productcollection.doc(id).delete();
  }
}
