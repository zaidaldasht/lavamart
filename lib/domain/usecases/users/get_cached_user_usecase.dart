import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/use_case.dart';
import '../../entities/users/user.dart';
import '../../reposetories/user_reposetory.dart';

class GetCachedUserUseCase implements UseCase<User, NoParams> {
  final UserRepository repository;
  GetCachedUserUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getCachedUser();
  }
}
