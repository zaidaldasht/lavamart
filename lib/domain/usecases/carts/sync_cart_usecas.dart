import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/use_case.dart';
import '../../entities/cart/cart_item.dart';
import '../../reposetories/cart_reposetory.dart';

class SyncCartUseCase implements UseCase<List<CartItem>, NoParams> {
  final CartRepository repository;
  SyncCartUseCase(this.repository);

  @override
  Future<Either<Failure, List<CartItem>>> call(NoParams params) async {
    return await repository.syncCart();
  }
}
