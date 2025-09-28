import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/use_case.dart';
import '../../entities/cart/cart_item.dart';
import '../../reposetories/cart_reposetory.dart';

class GetCachedCartUseCase implements UseCase<List<CartItem>, NoParams> {
  final CartRepository repository;
  GetCachedCartUseCase(this.repository);

  @override
  Future<Either<Failure, List<CartItem>>> call(NoParams params) async {
    return await repository.getCachedCart();
  }
}