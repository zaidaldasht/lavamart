import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/use_case.dart';
import '../../entities/cart/cart_item.dart';
import '../../reposetories/cart_reposetory.dart';

class AddCartUseCase implements UseCase<void, CartItem> {
  final CartRepository repository;
  AddCartUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(CartItem params) async {
    return await repository.addToCart(params);
  }
}
