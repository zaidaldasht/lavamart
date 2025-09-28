import 'package:bloc/bloc.dart';

import '../../domain/entities/orders/order.dart';
import '../../domain/usecases/orders/add_order_usecase.dart';
import 'package:flutter/material.dart';

part 'order_add_state.dart';

class OrderAddCubit extends Cubit<OrderAddState> {
  final AddOrderUseCase _addOrderUseCase;
  OrderAddCubit(this._addOrderUseCase) : super(OrderAddInitial());

  void addOrder(OrderDetails params) async {
    try {
      emit(OrderAddLoading());
      final result = await _addOrderUseCase(params);
      result.fold(
            (failure) => emit(OrderAddFail()),
            (order) => emit(OrderAddSuccess(order)),
      );
    } catch (e) {
      emit(OrderAddFail());
    }
  }
}
