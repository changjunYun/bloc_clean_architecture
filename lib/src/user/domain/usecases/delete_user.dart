import 'package:bloc_clean_architecture/core/usecase/usecase.dart';
import 'package:bloc_clean_architecture/core/utils/typedef.dart';
import 'package:bloc_clean_architecture/src/user/domain/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

class DeleteUser extends UsecaseWithParams<void, DeleteUserUserParams>{
  const DeleteUser(this._repository);

  final UserRepository _repository;

  @override
  ResultFuture<void> call(params) async => _repository.deleteUser(id: params.id);
}

class DeleteUserUserParams extends Equatable{
  const DeleteUserUserParams({
    required this.id,
  });

  const DeleteUserUserParams.empty()
      :this(
      id: '_empty,id',

  );

  final String id;

  @override
  List<Object?> get props => [id];
}