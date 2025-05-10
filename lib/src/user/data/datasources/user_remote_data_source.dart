import 'dart:convert';

import 'package:bloc_clean_architecture/src/user/domain/entities/user.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource{
  Future<void> createUser({
    required String createdAt,
    required String name,
  });
  Future<List<User>> getUser();
}

const kCreateUserEndpoint = '/users';

class UserRemoteDataSrcImpl implements UserRemoteDataSource {
  const UserRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
  }) async {
    try {
      final response = await _client.post(
          Uri.https(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode({
            'createdAt': createdAt,
            'name': name,
          }),
          headers: {
            'Content-Type': 'application/json'
          }
      );
      if(response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on APIException {
      rethrow;
    } catch(e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<User>> getUser() async {
    try {
      final response = await _client.get(
        Uri.https(kBaseUrl, kCreateUserEndpoint),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      final decoded = jsonDecode(response.body) as List<dynamic>;

      final users = decoded
          .map((e) => UserModel.fromMap(e as Map<String, dynamic>))
          .toList();

      return users;
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}