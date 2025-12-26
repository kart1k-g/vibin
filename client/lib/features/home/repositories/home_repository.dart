import 'dart:io';

import 'package:client/core/app_failure/app_failure.dart';
import 'package:client/core/constants/server_constants.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(Ref ref) => HomeRepository();

class HomeRepository {
  Future<Either<AppFailure, String>> uploadSong({
    required File selectedAudio,
    required File selectedImage,
    required String artist,
    required String songName,
    required String hexCode,
    required String token,
  }) async {
    try {
      final req = http.MultipartRequest(
        "POST",
        Uri.parse("${ServerConstants.serverURL}/song/upload"),
      );
      req
        ..files.addAll([
          await http.MultipartFile.fromPath('song', selectedAudio.path),
          await http.MultipartFile.fromPath('thumbnail', selectedImage.path),
        ])
        ..fields.addAll({
          'artist': artist,
          'song_name': songName,
          'hex_code': hexCode,
        })
        ..headers.addAll({'x-auth-token': token});

      final res = await req.send();
      if (res.statusCode != 201) {
        return Left(AppFailure(msg: await res.stream.bytesToString()));
      }
      return Right(await res.stream.bytesToString());
    } catch (e) {
      return Left(AppFailure(msg: e.toString()));
    }
  }
}
