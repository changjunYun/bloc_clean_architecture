import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/user/domain/usecases/get_user.dart';
import 'package:bloc_clean_architecture/src/user/domain/usecases/update_user.dart';
import 'package:bloc_clean_architecture/src/user/presentation/cubit/user_state.dart';

import '../../domain/usecases/create_user.dart';
import '../../domain/usecases/delete_user.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(
      {required CreateUser createUser,
      required GetUser getUser,
      required UpdateUser updateUser,
      required DeleteUser deleteUser})
      : _createUser = createUser,
        _getUser = getUser,
        _updateUser = updateUser,
        _deleteUser = deleteUser,
        super(const UserInitial());

  final CreateUser _createUser;
  final GetUser _getUser;
  final UpdateUser _updateUser;
  final DeleteUser _deleteUser;

  Future<void> createUser({
    required String createdAt,
    required String name,
  }) async {
    emit(const CreatingUser());
    // 원래는 await _createUser.call() 인데 call이 생략됨
    final result = await _createUser(CreateUserParams(
      createdAt: createdAt,
      name: name,
    ));

    result.fold(
      (failure) => emit(UserError(failure.errorMessage)),
      (_) => emit(const UserCreated()),
    );
  }

  Future<void> updateUser({
    required String id,
    required String updatedAt,
    required String name,
  }) async {
    emit(const UpdatingUser());

    final result = await _updateUser(
        UpdateUserParams(id: id, updatedAt: updatedAt, name: name));

    result.fold(
      (failure) => emit(UserError(failure.errorMessage)),
      (_) => emit(const UserUpdated()),
    );
  }

  Future<void> deleteUser({
    required String id
  }) async {
    emit(const DeletingUser());

    final result = await _deleteUser(
      DeleteUserUserParams(id: id));

    result.fold(
          (failure) => emit(UserError(failure.errorMessage)),
          (_) => emit(const UserDeleted()),
    );
  }

  Future<void> getUser() async {
    emit(const GettingUsers());

    final result = await _getUser();

    result.fold(
      (failure) => emit(UserError(failure.errorMessage)),
      (users) => emit(UsersLoaded(users)),
    );
  }
}
