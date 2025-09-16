// This is cart Model
class CartModel {
    String? id;
    String? productName;
    String? productId;
    String? productIamge;
    String? productDescription;
    String? productPrice;
    String? userId;
    int? quantity;

    CartModel({
        this.id,
        this.productName,
        this.productId,
        this.productIamge,
        this.productDescription,
        this.productPrice,
        this.userId,
        this.quantity,
    });

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        productName: json["ProductName"],
        productId: json["ProductId"],
        productIamge: json["ProductIamge"],
        productDescription: json["ProductDescription"],
        productPrice: json["ProductPrice"],
        userId: json["UserId"],
        quantity: json["Quantity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ProductName": productName,
        "ProductId": productId,
        "ProductIamge": productIamge,
        "ProductDescription": productDescription,
        "ProductPrice": productPrice,
        "UserId": userId,
        "Quantity": quantity,
    };

  copyWith({required String id}) {}
}
