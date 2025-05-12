import 'package:bloc_clean_architecture/core/usecase/usecase.dart';
import 'package:bloc_clean_architecture/core/utils/typedef.dart';
import 'package:bloc_clean_architecture/src/user/domain/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateUser extends UsecaseWithParams<void, UpdateUserParams>{
  const UpdateUser(this._repository);

  final UserRepository _repository;

  /***
   *  @override
      ResultFuture<void> call(params) async {
        return await _repository.updateUser(updatedAt: params.updatedAt, name: params.name)
      };
   ***/

  @override
  ResultFuture<void> call(params) async => _repository.updateUser(id: params.id, updatedAt: params.updatedAt, name: params.name);
}

class UpdateUserParams extends Equatable{
  const UpdateUserParams({
    required this.id,
    required this.updatedAt,
    required this.name
});

  const UpdateUserParams.empty()
  :this(
    id: '_empty,id',
    updatedAt: '_empty.updatedAt',
    name : '_empty.name'
  );

  final String updatedAt;
  final String name;
  final String id;

  @override
  List<Object?> get props => [id, updatedAt, name];
}