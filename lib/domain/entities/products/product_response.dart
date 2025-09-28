
import 'package:lavamart/domain/entities/products/pagination_meta_data.dart';
import 'package:lavamart/domain/entities/products/product.dart';

class ProductResponse {
  final List<ProductEntity> products;
  final PaginationMetaData paginationMetaData;

  ProductResponse({required this.products, required this.paginationMetaData});
}