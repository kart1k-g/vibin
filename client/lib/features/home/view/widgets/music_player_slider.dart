import 'package:client/core/providers/current_song_notifier.dart';
import 'package:client/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicPlayerSlider extends ConsumerStatefulWidget {
  const MusicPlayerSlider({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MusicPlayerSliderState();
}

class _MusicPlayerSliderState extends ConsumerState<MusicPlayerSlider> {
  late double _percentageComplete;
  late bool _isSliding;
  @override
  void initState() {
    _percentageComplete = 0;
    _isSliding = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentSongNotifier = ref.watch(currentSongProvider.notifier);
    return StreamBuilder(
      stream: currentSongNotifier.durationStream,
      builder: (context, asyncSnapshot) {
        Duration? pos = Duration.zero;
        Duration? duration = Duration(seconds: 1);

        //disables  slider update by the stream builder when the user is sliding it manually
        if (!_isSliding) {
          pos = asyncSnapshot.data;
          duration = currentSongNotifier.duration;
          if (asyncSnapshot.connectionState != ConnectionState.waiting) {
            if (pos != null && duration != null) {
              _percentageComplete = pos.inMilliseconds / duration.inMilliseconds;
            }
          } else {
            _percentageComplete = 0;
            pos = Duration.zero;
            duration = Duration(seconds: 1);
          }
        }

        return Column(
          children: [
            SliderTheme(
              data: SliderThemeData(
                activeTrackColor: Pallete.whiteColor,
                inactiveTrackColor: Pallete.inactiveSeekColor.withValues(
                  alpha: 0.117,
                ),
                thumbColor: Pallete.whiteColor,
                trackHeight: 4,
                overlayShape: SliderComponentShape.noOverlay,
              ),
              child: Slider(
                value: _percentageComplete,
                min: 0.0,
                max: 1.0,
                onChanged: (value) {
                  _isSliding = true;
                  setState(() {
                    _percentageComplete = value;
                  });
                },
                onChangeEnd: (value) {
                  currentSongNotifier.setSeek(value);
                  _isSliding = false;
                },
              ),
            ),

            Row(
              children: [
                Text(
                  '${pos!.inMinutes}:${pos.inSeconds % 60 < 10 ? "0" : ""}${pos.inSeconds % 60}',
                  style: TextStyle(
                    color: Pallete.subtitleText,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),

                Expanded(child: SizedBox()),

                Text(
                  '${duration!.inMinutes}:${duration.inSeconds % 60 < 10 ? "0" : ""}${duration.inSeconds % 60}',
                  style: TextStyle(
                    color: Pallete.subtitleText,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
