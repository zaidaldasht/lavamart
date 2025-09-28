



import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/network_info.dart';
import '../../domain/entities/categories/category.dart';
import '../../domain/reposetories/category_reposetory.dart';
import '../data_sources/local/category_local_data_source.dart';
import '../data_sources/remot/category_remote_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;
  final CategoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Category>>> getRemoteCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getCategories();
        localDataSource.saveCategories(remoteProducts);
        return Right(remoteProducts);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCachedCategories() async {
    try {
      final localProducts = await localDataSource.getCategories();
      return Right(localProducts);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<Category>>> filterCachedCategories(params) async {
    try {
      final cachedCategories = await localDataSource.getCategories();
      final categories = cachedCategories;
      final filteredCategories = categories
          .where((element) =>
          element.CategoryName.toLowerCase().contains(params.toLowerCase()))
          .toList();
      return Right(filteredCategories);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
