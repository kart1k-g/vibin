import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:client/core/theme/app_palette.dart';
import 'package:client/features/home/view/widgets/upload_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioWave extends ConsumerStatefulWidget {
  final String audioPath;
  const AudioWave({super.key, required this.audioPath});

  @override
  ConsumerState<AudioWave> createState() => _AudioWaveState();
}

class _AudioWaveState extends ConsumerState<AudioWave> {
  late PlayerController _playerController;

  @override
  void initState() {
    super.initState();
    _playerController = PlayerController();
    initAudioPlayer();
  }

  void initAudioPlayer() async {
    await _playerController.preparePlayer(path: widget.audioPath);
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  Future<void> playAndPause() async {
    if (!_playerController.playerState.isPlaying) {
      await _playerController.startPlayer();
    } else if (!_playerController.playerState.isPaused) {
      await _playerController.pausePlayer();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: playAndPause,
          icon: Icon(
            _playerController.playerState.isPlaying
                ? CupertinoIcons.pause_solid
                : CupertinoIcons.play_arrow_solid,
          ),
        ),
        Expanded(
          child: AudioFileWaveforms(
            size: const Size(double.infinity, 52),
            playerController: _playerController,
            playerWaveStyle: const PlayerWaveStyle(
              scrollScale: 1.1,
              fixedWaveColor: Pallete.whiteColor,
              liveWaveColor: Pallete.gradient2,
              spacing: 6,
              showSeekLine: false,
            ),
            waveformType: WaveformType.long,
          ),
        ),
        IconButton(
          onPressed: () {
            ref.read(audioNotifierProvider.notifier).state = null;
          },
          icon: Icon(Icons.close),
        ),
      ],
    );
  }
}
