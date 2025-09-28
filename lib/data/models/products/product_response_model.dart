import 'dart:convert';
import 'package:lavamart/data/models/products/pagination_data_model.dart';
import 'package:lavamart/data/models/products/product_model.dart';
import '../../../domain/entities/products/pagination_meta_data.dart';
import '../../../domain/entities/products/product.dart';
import '../../../domain/entities/products/product_response.dart';

ProductResponseModel productResponseModelFromJson(String str) =>
    ProductResponseModel.fromJson(json.decode(str));

String productResponseModelToJson(ProductResponseModel data) =>
    json.encode(data.toJson());

class ProductResponseModel extends ProductResponse {
  ProductResponseModel({
    required PaginationMetaData meta,
    required List<ProductEntity> data,
  }) : super(products: data, paginationMetaData: meta);

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductResponseModel(
        meta: PaginationMetaDataModel.fromJson(json["meta"]),
        data: List<ProductModel>.from(
            json["data"].map((x) => ProductModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "meta": (paginationMetaData as PaginationMetaDataModel).toJson(),
    "data": List<dynamic>.from((products as List<ProductModel>).map((x) => x.toJson())),
  };
}
