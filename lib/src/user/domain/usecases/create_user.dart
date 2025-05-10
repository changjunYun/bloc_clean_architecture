import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/user_repository.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  const CreateUser(this._repository);

  final UserRepository _repository;

  @override
  ResultVoid call(CreateUserParams params) async => _repository.createUser(
    createdAt: params.createdAt,
    name: params.name,

  );
}

class CreateUserParams extends Equatable {
  const CreateUserParams({
    required this.createdAt,
    required this.name,
  });

  const CreateUserParams.empty()
      : this(
    createdAt: '_empty.createdAt',
    name: '_empty.name',
  );

  final String createdAt;
  final String name;

  @override
  List<Object?> get props => [createdAt, name];
}