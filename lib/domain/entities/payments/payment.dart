import 'package:equatable/equatable.dart';



class Payment extends Equatable {
  final int PaymentId;
  final int OrderId;
  final String PaymentMethod;
  final int Amount;
  final String Status;
  final DateTime? PaymentDate;


  const Payment({required this.PaymentId, required this.OrderId, required this.PaymentMethod, required this.Amount, required this.Status, this.PaymentDate});

  @override
  List<Object?> get props => [PaymentId];
}
