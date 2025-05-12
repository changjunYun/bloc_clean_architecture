import 'package:bloc_clean_architecture/src/user/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImplementation implements UserRepository {

  const UserRepositoryImplementation(this._remoteDataSource);

  final UserRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser({required String createdAt, required String name,}) async {
    try {
      await _remoteDataSource.createUser(createdAt: createdAt, name: name);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
  @override
  ResultVoid updateUser({required String id, required String updatedAt, required String name}) async{
    try {
      await _remoteDataSource.updateUser(id : id, updatedAt: updatedAt, name: name);
      return const Right(null);
    }on APIException catch(e){
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUser() async{
    try {
      final data = await _remoteDataSource.getUser();
      return Right(data);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteUser({required String id}) async{
    try {
      await _remoteDataSource.deleteUser(id : id);
      return const Right(null);
    }on APIException catch(e){
      return Left(APIFailure.fromException(e));
    }
  }
}