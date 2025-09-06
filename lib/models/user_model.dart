class UserModels {
  String? uid;
  String? firstName;
  String? lastName;
  String? email;
  String? address;

  UserModels({
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.address,
  });

  factory UserModels.fromJson(Map<String, dynamic> json) => UserModels(
        uid: json["uid"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "address": address,
      };
}
