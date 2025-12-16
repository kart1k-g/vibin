import 'dart:convert';

import 'package:client/core/app_failure/app_failure.dart';
import 'package:client/core/constants/server_constants.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(Ref ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<Either<AppFailure, UserModel>> signup({
    required name,
    required password,
    required email,
  }) async {
    try {
      final url = Uri.parse("${ServerConstants.serverURL}/auth/signup");
      final headers = {"content-type": "application/json"};
      final body = jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      });
      final response = await http.post(url, headers: headers, body: body);
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 201) {
        return Left(AppFailure(msg: resBodyMap['detail']));
      }

      return Right(UserModel.fromMap(resBodyMap));
    } catch (e) {
      return Left(AppFailure(msg: e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> login({
    required password,
    required email,
  }) async {
    try {
      final url = Uri.parse("${ServerConstants.serverURL}/auth/login");
      final headers = {"content-type": "application/json"};
      final body = jsonEncode({"email": email, "password": password});
      final response = await http.post(url, headers: headers, body: body);
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        return Left(AppFailure(msg: resBodyMap["detail"]));
      }
      return Right(UserModel.fromMap(resBodyMap));
    } catch (e) {
      return Left(AppFailure(msg: e.toString()));
    }
  }
}
