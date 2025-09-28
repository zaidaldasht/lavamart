import '../../../domain/entities/products/product.dart';
import '../category/category_model.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required String ProductId,
    required String ProductName,
    required String Description,
    required double Price,
    required int StockQuantity,
    required List<CategoryModel> Categories,
    required List<String> Image,
    required DateTime Createdate,
  }) : super(
    ProductId: ProductId,
    ProductName: ProductName,
    Description: Description,
    Price: Price,
    StockQuantity: StockQuantity,
    Categories: Categories,
    Image: Image,
    Createdate: Createdate,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    ProductId: json["ProductId"],
    ProductName: json["ProductName"],
    Description: json["Description"],
    Price: json["Price"],
    StockQuantity: json["StockQuantity"],
    Categories: List<CategoryModel>.from(
        json["Categories"].map((x) => CategoryModel.fromJson(x))),
    Image: List<String>.from(json["Image"].map((x) => x)),
    Createdate: DateTime.parse(json["Createdate"]),
  );

  Map<String, dynamic> toJson() => {
    "ProductId": ProductId,
    "ProductName": ProductName,
    "Description": Description,
    "Price": Price,
    "StockQuantity": StockQuantity,
    "Categories": List<dynamic>.from(
        (Categories as List<CategoryModel>).map((x) => x.toJson())),
    "Image": List<dynamic>.from(Image.map((x) => x)),
    "Createdate": Createdate.toIso8601String(),
  };

  factory ProductModel.fromEntity(ProductEntity entity) => ProductModel(
    ProductId: entity.ProductId,
    ProductName: entity.ProductName,
    Description: entity.Description,
    Price: entity.Price,
    StockQuantity: entity.StockQuantity,
    Categories: entity.Categories
        .map((category) => CategoryModel.fromEntity(category))
        .toList(),
    Image: entity.Image,
    Createdate: entity.Createdate,
  );
}
