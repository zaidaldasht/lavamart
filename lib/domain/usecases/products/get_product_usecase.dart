
import '../../../core/error/failures.dart';
import '../../../core/use_case.dart';
import '../../../data/models/products/filter_params_model.dart';
import '../../entities/products/product_response.dart';
import '../../reposetories/product_reposetory.dart';
import 'package:dartz/dartz.dart';

class GetProductUseCase implements UseCase<ProductResponse, FilterProductParams> {
  final ProductRepository repository;
  GetProductUseCase(this.repository);

  @override
  Future<Either<Failure, ProductResponse>> call(FilterProductParams params) async {
    return await repository.getProducts(params);
  }
}

