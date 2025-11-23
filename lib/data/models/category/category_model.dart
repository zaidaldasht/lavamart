import 'dart:convert';
import '../../../domain/entities/categories/category.dart';

List<CategoryModel> categoryModelListFromRemoteJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str)['data'].map((x) => CategoryModel.fromJson(x)));

List<CategoryModel> categoryModelListFromLocalJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelListToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel extends Category {
  const CategoryModel({
    required String CategoryId,
    required String CategoryName,
    required String Description,
    String? Categoryimage,

  }) : super(
    CategoryId: CategoryId,
    CategoryName: CategoryName,
    Description: Description,
    Categoryimage: Categoryimage ?? '',
  );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    CategoryId: json["CategoryId"],
    CategoryName: json["CategoryName"],
    Description: json["Description"],
    Categoryimage: json["Categoryimage"],

  );

  Map<String, dynamic> toJson() => {
    "CategoryId": CategoryId,
    "CategoryName": CategoryName,
    "Description": Description,
    "Categoryimage": Categoryimage,

  };

  factory CategoryModel.fromEntity(Category entity) => CategoryModel(
    CategoryId: entity.CategoryId,
    CategoryName: entity.CategoryName,
    Description: entity.Description,
    Categoryimage: entity.Categoryimage,

  );
}
