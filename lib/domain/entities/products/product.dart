import 'package:equatable/equatable.dart';
import '../categories/category.dart';

class ProductEntity extends Equatable {
  final String ProductId;
  final String ProductName;
  final String Description;
  final double Price;
  final int StockQuantity;
  final List<Category> Categories;
  final List<String> Image;
  final DateTime Createdate;


  const ProductEntity({
    required this.ProductId,
    required this.ProductName,
    required this.Description,
    required this.Price,
    required this.Categories,
    required this.Image,
    required this.Createdate,
    required this.StockQuantity,
  });

  @override
  List<Object?> get props => [ProductId];
}