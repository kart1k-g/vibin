import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:client/core/app_failure/app_failure.dart';
import 'package:client/core/constants/server_constants.dart';
import 'package:client/features/home/models/song_model.dart';
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
      final songJson = jsonEncode({
        'artist': artist,
        'name': songName,
        'hexcode': hexCode,
      });
      req.files.add(
        http.MultipartFile.fromString(
          'song',
          songJson,
          contentType: MediaType('application', 'json'),
        ),
      );
      req
        ..files.addAll([
          await http.MultipartFile.fromPath('audio', selectedAudio.path),
          await http.MultipartFile.fromPath('thumbnail', selectedImage.path),
        ])
        ..headers.addAll({'Authorization': 'Bearer $token'});

      final res = await req.send();
      if (res.statusCode != 201) {
        return Left(AppFailure(msg: await res.stream.bytesToString()));
      }
      return Right(await res.stream.bytesToString());
    } catch (e) {
      return Left(AppFailure(msg: e.toString()));
    }
  }

  Future<Either<AppFailure, List<SongModel>>> getAllSongs(String token) async {
    try {
      final res = await http.get(
        Uri.parse('${ServerConstants.serverURL}/song/list'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      var resBodyMap = jsonDecode(res.body);
      resBodyMap = resBodyMap as Map<String, dynamic>;
      if (res.statusCode != 200) {
        return Left(AppFailure(msg: resBodyMap['message']));
      }

      List<SongModel> songs = [];
      for (final map in resBodyMap['data']) {
        songs.add(SongModel.fromMap(map));
      }
      log(songs.toString());
      return Right(songs);
    } catch (e) {
      return Left(AppFailure(msg: e.toString()));
    }
  }
}
