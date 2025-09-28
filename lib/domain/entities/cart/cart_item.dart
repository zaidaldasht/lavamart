import 'package:equatable/equatable.dart';
import '../products/product.dart';

class CartItem extends Equatable {
  final String CartItemId;
  final String CartId;
  final ProductEntity product;
  final int Quantity;

  const CartItem({required this.CartItemId, required this.CartId , required this.product, required this.Quantity});

  @override
  List<Object?> get props => [CartItemId];
}
