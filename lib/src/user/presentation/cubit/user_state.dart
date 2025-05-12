import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}
// 초기 상태
class UserInitial extends UserState {
  const UserInitial();
}

// 사용자 생성 중
class CreatingUser extends UserState {
  const CreatingUser();
}

// 사용자 생성 완료
class UserCreated extends UserState {
  const UserCreated();
}
// 사용자 수정 중
class UpdatingUser extends UserState {
  const UpdatingUser();
}

// 사용자 수정 완료
class UserUpdated extends UserState {
  const UserUpdated();
}
// 사용자 목록 요청 중
class GettingUsers extends UserState {
  const GettingUsers();
}

// 사용자 목록 로딩 완료
class UsersLoaded extends UserState {
  const UsersLoaded(this.users);

  final List<User> users;

  @override
  List<Object> get props => users.map((user) => user.id).toList();
}

// 에러 발생 시
class UserError extends UserState {
  const UserError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}