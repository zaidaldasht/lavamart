import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/use_case.dart';
import '../../entities/categories/category.dart';
import '../../reposetories/category_reposetory.dart';

class GetRemoteCategoryUseCase implements UseCase<List<Category>, NoParams> {
  final CategoryRepository repository;
  GetRemoteCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) async {
    return await repository.getRemoteCategories();
  }
}
