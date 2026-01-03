import 'package:client/core/providers/current_song_notifier.dart';
import 'package:client/core/theme/app_palette.dart';
import 'package:client/core/utils.dart';
import 'package:client/features/home/view/widgets/music_player_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicPlayer extends ConsumerWidget {
  const MusicPlayer({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongProvider);
    final currentSongNotifier = ref.watch(currentSongProvider.notifier);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [hexToRgb(currentSong!.hex_code), Color(0xff121212)],
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Scaffold(
        backgroundColor: Pallete.transparentColor,
        appBar: AppBar(
          backgroundColor: Pallete.transparentColor,
          leading: Transform.translate(
            offset: Offset(-15, 0),
            child: InkWell(
              splashColor: Pallete.transparentColor,
              highlightColor: Pallete.transparentColor,
              focusColor: Pallete.transparentColor,
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset("assets/images/pull_down_arrow.png"),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Hero(
                  tag: "music_image",
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(currentSong.thumbnail_url),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentSong.song_name,
                            style: TextStyle(
                              color: Pallete.whiteColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            currentSong.artist,
                            style: TextStyle(
                              color: Pallete.subtitleText,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.heart,
                          color: Pallete.whiteColor,
                        ),
                      ),
                    ],
                  ),

                  MusicPlayerSlider(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Image.asset("assets/images/shuffle.png"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Image.asset("assets/images/previous_song.png"),
                      ),
                      StreamBuilder(
                        stream: currentSongNotifier.isPlayingStream,
                        builder: (context, asyncSnapshot) {
                          final isPlaying = asyncSnapshot.data ?? false;
                          return IconButton(
                            onPressed: () {
                              currentSongNotifier.togglePlayPause();
                            },
                            icon: Icon(
                              isPlaying
                                  ? CupertinoIcons.pause_circle_fill
                                  : CupertinoIcons.play_circle_fill,
                              size: 72,
                              color: Pallete.whiteColor,
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Image.asset("assets/images/next_song.png"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Image.asset("assets/images/repeat.png"),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Image.asset("assets/images/connect_device.png"),
                      ),
                      Expanded(child: SizedBox()),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Image.asset("assets/images/playlist.png"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
