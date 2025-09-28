import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/use_case.dart';
import '../entities/users/user.dart';
import '../usecases/users/sign_in_usecase.dart';
import '../usecases/users/sign_up_usecase.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> signIn(SignInParams params);
  Future<Either<Failure, User>> signUp(SignUpParams params);
  Future<Either<Failure, NoParams>> signOut();
  Future<Either<Failure, User>> getCachedUser();
}
