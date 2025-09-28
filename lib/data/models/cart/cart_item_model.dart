import 'dart:convert';

import '../../../domain/entities/cart/cart_item.dart';
import '../products/product_model.dart';



List<CartItemModel> cartItemModelListFromLocalJson(String str) =>
    List<CartItemModel>.from(
        json.decode(str).map((x) => CartItemModel.fromJson(x)));

List<CartItemModel> cartItemModelListFromRemoteJson(String str) =>
    List<CartItemModel>.from(
        json.decode(str)["data"].map((x) => CartItemModel.fromJson(x)));

String cartItemModelToJson(List<CartItemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class CartItemModel extends CartItem {
  const CartItemModel({
    required String CartItemId,
    required String CartId,
    required ProductModel product,
    required int Quantity,
  }) : super(CartItemId: CartItemId, CartId: CartId, product: product, Quantity: Quantity);

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      CartItemId: json["CartItemId"],
      CartId: json["CartId"],
      product: ProductModel.fromJson(json["product"]),
      Quantity: json["Quantity"],
    );
  }

  Map<String, dynamic> toJson() => {
    "CartItemId": CartItemId,
    "CartId": CartId,
    "product": (product as ProductModel).toJson(),
    "Quantity": Quantity,
  };

  Map<String, dynamic> toBodyJson() => {
    "CartItemId": CartItemId,
    "CartId": CartId,
    "product": product.ProductId,
    "Quantity": Quantity,
  };

  factory CartItemModel.fromParent(CartItem cartItem) {
    return CartItemModel(
      CartItemId: cartItem.CartItemId,
      CartId: cartItem.CartId,
      product: cartItem.product as ProductModel ,
      Quantity: cartItem.Quantity,
    );
  }
}
