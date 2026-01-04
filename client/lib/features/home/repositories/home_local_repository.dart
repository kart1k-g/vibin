import 'package:client/features/home/models/song_model.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_local_repository.g.dart';

@Riverpod(keepAlive: true)
HomeLocalRepository homeLocalRepository(Ref ref) => HomeLocalRepository();

class HomeLocalRepository {
  final Box box = Hive.box("songs");

  void uploadLocalSongs(SongModel song) {
    box.put(song.id, song.toJson());
  }

  List<SongModel> loadSongs({int limit=-1}) {
    List<SongModel> songs = [];
    for (final key in box.keys) {
      songs.add(SongModel.fromJson(box.get(key)));
      if (limit==songs.length) {
        break;
      }
    }
    return songs;
  }
}
