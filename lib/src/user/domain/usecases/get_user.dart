import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUser extends UsecaseWithoutParams<List<User>> {
  const GetUser(this._repository);

  final UserRepository _repository;

  @override
  ResultFuture<List<User>> call() => _repository.getUser();
}