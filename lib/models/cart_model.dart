// This is cart Model
class CartModel {
    String? id;
    String? productName;
    String? productId;
    String? productImage;
    String? productDescription;
    String? productPrice;
    String? userId;
    int? quantity;

    CartModel({
        this.id,
        this.productName,
        this.productId,
        this.productImage,
        this.productDescription,
        this.productPrice,
        this.userId,
        this.quantity,
    });

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        productName: json["ProductName"],
        productId: json["ProductId"],
        productImage: json["ProductIamge"],
        productDescription: json["ProductDescription"],
        productPrice: json["ProductPrice"],
        userId: json["UserId"],
        quantity: json["Quantity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ProductName": productName,
        "ProductId": productId,
        "ProductIamge": productImage,
        "ProductDescription": productDescription,
        "ProductPrice": productPrice,
        "UserId": userId,
        "Quantity": quantity,
    };

  copyWith({required String id}) {}
}
