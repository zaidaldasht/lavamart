import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/use_case.dart';
import '../../entities/cart/cart_item.dart';
import '../../reposetories/cart_reposetory.dart';

class ClearCartUseCase implements UseCase<bool, NoParams> {
  final CartRepository repository;
  ClearCartUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.clearCart();
  }
}

