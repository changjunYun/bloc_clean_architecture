import 'package:bloc_clean_architecture/src/user/domain/usecases/get_user.dart';
import 'package:bloc_clean_architecture/src/user/domain/usecases/update_user.dart';
import 'package:bloc_clean_architecture/src/user/presentation/notifier/user_state.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/usecases/create_user.dart';
import '../../domain/usecases/delete_user.dart';

class UserNotifier extends ChangeNotifier {
  UserNotifier(
      {required CreateUser createUser,
      required GetUser getUser,
      required UpdateUser updateUser,
      required DeleteUser deleteUser})
      : _createUser = createUser,
        _getUser = getUser,
        _updateUser = updateUser,
        _deleteUser = deleteUser,
        super();

  final CreateUser _createUser;
  final GetUser _getUser;
  final UpdateUser _updateUser;
  final DeleteUser _deleteUser;

  UserState _state = UserInitial();
  UserState get state => _state;

  void _emit(UserState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> createUser({
    required String createdAt,
    required String name,
  }) async {
    _emit(const CreatingUser());

    final result = await _createUser(CreateUserParams(
      createdAt: createdAt,
      name: name,
    ));

    result.fold(
      (failure) => _emit(UserError(failure.errorMessage)),
      (_) => getUser(),
    );
  }

  Future<void> updateUser({
    required String id,
    required String updatedAt,
    required String name,
  }) async {
    _emit(const UpdatingUser());

    final result = await _updateUser(
        UpdateUserParams(id: id, updatedAt: updatedAt, name: name));

    result.fold(
      (failure) => _emit(UserError(failure.errorMessage)),
      (_) => getUser(),
    );
  }

  Future<void> deleteUser({
    required String id
  }) async {
    _emit(const DeletingUser());

    final result = await _deleteUser(
      DeleteUserUserParams(id: id));

    result.fold(
          (failure) => _emit(UserError(failure.errorMessage)),
          (_) => getUser(),
    );
  }

  Future<void> getUser() async {
    _emit(const GettingUsers());

    final result = await _getUser();

    result.fold(
      (failure) => _emit(UserError(failure.errorMessage)),
      (users) => _emit(UsersLoaded(users)),
    );
  }
}
