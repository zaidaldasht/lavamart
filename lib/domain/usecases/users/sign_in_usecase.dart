import '../../../core/error/failures.dart';
import '../../../core/use_case.dart';
import '../../entities/users/user.dart';
import '../../reposetories/user_reposetory.dart';
import 'package:dartz/dartz.dart';

class SignInUseCase implements UseCase<User, SignInParams> {
  final UserRepository repository;
  SignInUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(SignInParams params) async {
    return await repository.signIn(params);
  }
}

class SignInParams {
  final String username;
  final String password;
  const SignInParams({
    required this.username,
    required this.password,
  });
}