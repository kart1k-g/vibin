import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/auth/repository/auth_local_repository.dart';
import 'package:client/features/auth/repository/auth_remote_repository.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_user_notifier.g.dart';

// @Riverpod(keepAlive: true)
@riverpod
class CurrentUserNotifier extends _$CurrentUserNotifier {
  late final AuthLocalRepository _authLocalRepository;
  late final AuthRemoteRepository _authRemoteRepository;
  @override
  UserModel? build() {
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    init();
    return null;
  }

  Future<void> init() async {
    // _authLocalRepository.removeToken();
    final token = _authLocalRepository.getToken();
    if (token == null) return;

    final response = await _authRemoteRepository.getUserData(token);
    final value = switch (response) {
      fp.Left() => null,
      fp.Right(value: final data) => data,
    };
    state = value;
  }

  void addUser(UserModel user) {
    state = user;
  }
}
