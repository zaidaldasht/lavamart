import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/use_case.dart';
import '../../entities/orders/order.dart';
import '../../reposetories/order_reposetory.dart';

class GetRemoteOrderUseCase implements UseCase<List<OrderDetails>, NoParams> {
  final OrderRepository repository;
  GetRemoteOrderUseCase(this.repository);

  @override
  Future<Either<Failure, List<OrderDetails>>> call(NoParams params) async {
    return await repository.getRemoteOrders();
  }
}
