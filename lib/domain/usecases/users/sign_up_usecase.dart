import '../../../core/error/failures.dart';
import '../../../core/use_case.dart';
import '../../entities/users/user.dart';
import '../../reposetories/user_reposetory.dart';
import 'package:dartz/dartz.dart';

class SignUpUseCase implements UseCase<User, SignUpParams> {
  final UserRepository repository;
  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return await repository.signUp(params);
  }
}

class SignUpParams {
  final String FullName;
  final String email;
  final String password;
  final String PhoneNumber;

  const SignUpParams({
    required this.FullName,
    required this.email,
    required this.password,
    required this.PhoneNumber,

  });
}
