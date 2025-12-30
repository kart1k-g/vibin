import 'package:client/features/home/models/song_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:just_audio/just_audio.dart';
part 'current_song_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentSongNotifier extends _$CurrentSongNotifier {
  late final AudioPlayer _audioPlayer;
  @override
  SongModel? build() {
    _audioPlayer = AudioPlayer();
    return null;
  }

  void updateSong(SongModel song) async {
    await _audioPlayer.stop();
    await _audioPlayer.seek(Duration.zero);
    final audioSource = AudioSource.uri(Uri.parse(song.song_url));
    await _audioPlayer.setAudioSource(audioSource);
    _audioPlayer.play();
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });
    state = song;
  }

  void togglePlayPause() {
    if (_audioPlayer.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  Stream<bool> get isPlayingStream => _audioPlayer.playingStream;

  Stream<Duration?> get durationStream => _audioPlayer.positionStream;

  Duration? get duration => _audioPlayer.duration;
}
