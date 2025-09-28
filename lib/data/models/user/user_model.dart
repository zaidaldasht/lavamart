import 'dart:convert';

import '../../../domain/entities/users/user.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends User {
  const UserModel({
    required String Id,
    required String UserName,
    String? image,
    required String Email,
  }) : super(
    Id: Id,
    UserName: UserName,
    image: image,
    Email: Email,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    Id: json["Id"],
    UserName: json["UserName"],
    image: json["image"],
    Email: json["Email"],
  );

  Map<String, dynamic> toJson() => {
    "Id": Id,
    "UserName": UserName,
    "image": image,
    "Email": Email,
  };
}
