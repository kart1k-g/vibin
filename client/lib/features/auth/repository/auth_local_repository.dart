import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authLocalRepositoryProvider=Provider<AuthLocalRepository>((ref)=> throw UnimplementedError());

class AuthLocalRepository {
  late final SharedPreferences _sharedPreferences;
  AuthLocalRepository._(this._sharedPreferences);

  static Future<AuthLocalRepository> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return AuthLocalRepository._(sharedPreferences);
  }

  String? getToken() {
    return _sharedPreferences.getString('x-auth-token');
  }

  Future<void> setToken(String? token) async {
    if (token != null) {
      _sharedPreferences.setString('x-auth-token', token);
    }
  }

  Future<void> removeToken() async {
    _sharedPreferences.remove('x-auth-token');
  }
}
