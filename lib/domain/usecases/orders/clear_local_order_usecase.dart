import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/use_case.dart';
import '../../entities/orders/order.dart';
import '../../reposetories/order_reposetory.dart';

class ClearLocalOrderUseCase implements UseCase<NoParams, NoParams> {
  final OrderRepository repository;
  ClearLocalOrderUseCase(this.repository);

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await repository.clearLocalOrders();
  }
}

