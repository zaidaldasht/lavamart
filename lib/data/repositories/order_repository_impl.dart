
import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/network_info.dart';
import '../../core/use_case.dart';
import '../../domain/entities/orders/order.dart';
import '../../domain/reposetories/order_reposetory.dart';
import '../data_sources/local/order_local_data_source.dart';
import '../data_sources/local/user_local_data_source.dart';
import '../data_sources/remot/order_remote_data_source.dart';
import '../models/order/order_details_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;
  final OrderLocalDataSource localDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  OrderRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.userLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, OrderDetails>> addOrder(OrderDetails params) async {
    if (await userLocalDataSource.isTokenAvailable()) {
      final String token = await userLocalDataSource.getToken();
      final remoteProduct = await remoteDataSource.addOrder(
        OrderDetailsModel.fromEntity(params),
        token,
      );
      return Right(remoteProduct);
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderDetails>>> getRemoteOrders() async {
    if (await networkInfo.isConnected) {
      if (await userLocalDataSource.isTokenAvailable()) {
        try {
          final String token = await userLocalDataSource.getToken();
          final remoteProduct = await remoteDataSource.getOrders(
            token,
          );
          await localDataSource.saveOrders(remoteProduct);
          return Right(remoteProduct);
        } on Failure catch (failure) {
          return Left(failure);
        }
      } else {
        return Left(AuthenticationFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderDetails>>> getCachedOrders() async {
    try {
      final localOrders = await localDataSource.getOrders();
      return Right(localOrders);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, NoParams>> clearLocalOrders() async {
    try {
      await localDataSource.clearOrder();
      return Right(NoParams());
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
