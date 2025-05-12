import 'package:bloc_clean_architecture/core/utils/typedef.dart';
import 'package:bloc_clean_architecture/src/user/domain/entities/user.dart';

abstract class UserRepository{
  const UserRepository();

  // ResultVoid는 결과 데이터는 필요 없지만, 성공/실패 여부는 명확하게 처리해야 하는 비동기 작업에 딱 맞는 반환 타입
  ResultVoid createUser({required String createdAt, required String name});

  // User 데이터를 불러오는 함수
  ResultFuture<List<User>> getUser();

  // User 데이터를 수정하는 함수
  ResultVoid updateUser({required String id, required String updatedAt, required String name});

  // User 데이터를 삭제하는 함수
  ResultVoid deleteUser({required String id});
}