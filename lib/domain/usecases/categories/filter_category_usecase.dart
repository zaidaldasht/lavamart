import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/use_case.dart';
import '../../entities/categories/category.dart';
import '../../reposetories/category_reposetory.dart';

class FilterCategoryUseCase implements UseCase<List<Category>, String> {
  final CategoryRepository repository;
  FilterCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(String params) async {
    return await repository.filterCachedCategories(params);
  }
}
