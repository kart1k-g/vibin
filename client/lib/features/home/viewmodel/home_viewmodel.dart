import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:client/core/utils.dart';
import 'package:client/features/auth/repository/auth_local_repository.dart';
import 'package:client/features/home/models/song_model.dart';
import 'package:client/features/home/repositories/home_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_viewmodel.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late final HomeRepository _homeRepository;
  late final AuthLocalRepository _authLocalRepository;
  @override
  AsyncValue? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    return null;
  }

  Future<void> uploadSong({
    required File selectedAudio,
    required File selectedImage,
    required String artist,
    required String songName,
    required Color color,
  }) async {
    state = AsyncValue.loading();
    final token = _authLocalRepository.getToken();
    final res = await _homeRepository.uploadSong(
      selectedAudio: selectedAudio,
      selectedImage: selectedImage,
      artist: artist,
      songName: songName,
      hexCode: rgbToHex(color),
      token: token!,
    );
    final value = switch (res) {
      Left(value: final l) => state = AsyncValue.error(
        l.msg,
        StackTrace.current,
      ),
      Right(value: final r) => state = AsyncValue.data(r),
    };
    log(value.toString());
  }
}

@riverpod
Future<List<SongModel>> getAllSongs(Ref ref) async {
  final homeRepository = ref.watch(homeRepositoryProvider);
  final token = ref.watch(authLocalRepositoryProvider).getToken();
  final res = await homeRepository.getAllSongs(token!);
  final value = switch (res) {
    Left(value: final l) => throw l.msg,
    Right(value: final r) => r,
  };
  return value;
}
