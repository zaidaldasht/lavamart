import 'dart:convert';

import '../../../domain/entities/orders/order.dart';


List<OrderDetailsModel> orderDetailsModelListFromJson(String str) =>
    List<OrderDetailsModel>.from(
        json.decode(str)['data'].map((x) => OrderDetailsModel.fromJson(x)));

List<OrderDetailsModel> orderDetailsModelListFromLocalJson(String str) =>
    List<OrderDetailsModel>.from(
        json.decode(str).map((x) => OrderDetailsModel.fromJson(x)));

OrderDetailsModel orderDetailsModelFromJson(String str) =>
    OrderDetailsModel.fromJson(json.decode(str)['data']);

String orderModelListToJsonBody(List<OrderDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String orderModelListToJson(List<OrderDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String orderDetailsModelToJson(OrderDetailsModel data) =>
    json.encode(data.toJson());

class OrderDetailsModel extends OrderDetails {
  const OrderDetailsModel({
    required String OrderId,
    required String Id,
    required DateTime OrderDate,
    required String Status,
    required double TotalAmount,
    required String ShippingAddress,
  }) : super(
    OrderId: OrderId,
    Id: Id,
    OrderDate: OrderDate,
    Status: Status,
    TotalAmount: TotalAmount,
    ShippingAddress: ShippingAddress,
  );

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        OrderId: json["OrderId"],
        Id: json["Id"],
        OrderDate: json["OrderDate"],
        Status: json["Status"],
        TotalAmount: json["TotalAmount"],
        ShippingAddress: json["ShippingAddress"],
      );

  Map<String, dynamic> toJson() => {
    "OrderId": OrderId,
    "Id": Id,
    "OrderDate": OrderDate,
    "Status": Status,
    "TotalAmount": TotalAmount,
    "ShippingAddress": ShippingAddress,
  };


  factory OrderDetailsModel.fromEntity(OrderDetails entity) =>
      OrderDetailsModel(
          OrderId: entity.OrderId,
          Id: entity.Id,
          OrderDate: entity.OrderDate,
          Status: entity.Status,
          TotalAmount: entity.TotalAmount,
          ShippingAddress: entity.ShippingAddress ,
      );
}
