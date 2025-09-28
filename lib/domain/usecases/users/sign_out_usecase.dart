import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/use_case.dart';
import '../../reposetories/user_reposetory.dart';

class SignOutUseCase implements UseCase<NoParams, NoParams> {
  final UserRepository repository;
  SignOutUseCase(this.repository);

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await repository.signOut();
  }
}
