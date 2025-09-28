import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/use_case.dart';
import '../../entities/orders/order.dart';
import '../../reposetories/order_reposetory.dart';

class AddOrderUseCase implements UseCase<OrderDetails, OrderDetails> {
  final OrderRepository repository;
  AddOrderUseCase(this.repository);

  @override
  Future<Either<Failure, OrderDetails>> call(OrderDetails params) async {
    return await repository.addOrder(params);
  }
}
