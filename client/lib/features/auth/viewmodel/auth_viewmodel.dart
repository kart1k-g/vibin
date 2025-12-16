import 'dart:developer';

import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/auth/repository/auth_remote_repository.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewmodel extends _$AuthViewmodel {
  late final AuthRemoteRepository _authRemoteRepository;
  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    return null;
  }

  Future<void> signupUser({
    required String name,
    required String email,
    required String password,
  }) async {
    state = AsyncValue.loading();
    final response = await _authRemoteRepository.signup(
      name: name,
      password: password,
      email: email,
    );
    final val = switch (response) {
      fp.Left(value: final l) => state = AsyncValue.error(
        l.msg,
        StackTrace.current,
      ),
      fp.Right(value: final r) => state = AsyncValue.data(r),
    };
    log(val.toString());
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    state = AsyncValue.loading();
    final response = await _authRemoteRepository.login(
      password: password,
      email: email,
    );
    final val = switch (response) {
      fp.Left(value: final l) => state = AsyncValue.error(
        l.msg,
        StackTrace.current,
      ),
      fp.Right(value: final r) => state = AsyncValue.data(r),
    };
    log(val.toString());
  }
}
