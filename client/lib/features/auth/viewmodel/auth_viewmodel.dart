import 'dart:developer';

import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/auth/repository/auth_local_repository.dart';
import 'package:client/features/auth/repository/auth_remote_repository.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewmodel extends _$AuthViewmodel {
  late final AuthRemoteRepository _authRemoteRepository;
  late final AuthLocalRepository _authLocalRepository;
  late final CurrentUserNotifier _currentUserNotifier;
  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserProvider.notifier);
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
      fp.Right(value: final r) => _loginSuccess(r),
    };
    log(val.toString());
  }

  AsyncValue<UserModel> _loginSuccess(UserModel user) {
    _authLocalRepository.setToken(user.token);
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }

  Future<UserModel?> getUserData() async {
    state = const AsyncValue.loading();
    final token = _authLocalRepository.getToken();
    if (token != null) {
      final response = await _authRemoteRepository.getUserData(token);
      final val = switch (response) {
        fp.Left(value: final l) => state = AsyncValue.error(
          l.msg,
          StackTrace.current,
        ),
        fp.Right(value:  final r) => _onUserDataSuccess(r),
      };
      return val.value;
    }
    return null;
  }

  AsyncValue<UserModel> _onUserDataSuccess(UserModel user) {
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }
}
