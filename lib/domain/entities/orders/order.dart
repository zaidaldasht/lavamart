import 'package:equatable/equatable.dart';


class OrderDetails extends Equatable {
  final String OrderId;
  final String Id;
  final DateTime OrderDate;
  final String Status;
  final double TotalAmount;
  final String ShippingAddress;


  const OrderDetails({
    required this.OrderId,
    required this.Id,
    required this.OrderDate,
    required this.Status,
    required this.TotalAmount,
    required this.ShippingAddress

  });

  @override
  List<Object> get props => [
    OrderId,
  ];
}
