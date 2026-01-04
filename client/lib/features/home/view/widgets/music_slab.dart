import 'package:client/core/providers/current_song_notifier.dart';
import 'package:client/core/theme/app_palette.dart';
import 'package:client/core/utils.dart';
import 'package:client/features/home/view/widgets/music_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicSlab extends ConsumerWidget {
  const MusicSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongProvider);
    final currentSongNotifier = ref.read(currentSongProvider.notifier);
    if (currentSong == null) {
      return const SizedBox();
    }
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return const MusicPlayer();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  final tween = Tween(
                    begin: Offset(0, 1),
                    end: Offset.zero,
                  ).chain(CurveTween(curve: Curves.easeIn));
                  final offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
          ),
        );
      },
      child: Stack(
        children: [
          Hero(
            tag: "music_image",
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              width: MediaQuery.of(context).size.width - 18,
              height: 60,
              decoration: BoxDecoration(
                color: hexToRgb(currentSong.hex_code),
                borderRadius: BorderRadius.circular(3),
              ),
              padding: EdgeInsets.all(6),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(currentSong.thumbnail_url),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentSong.song_name,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            currentSong.artist,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Pallete.subtitleText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.heart,
                          weight: 700,
                          color: Pallete.whiteColor,
                        ),
                      ),
                      StreamBuilder(
                        stream: currentSongNotifier.isPlayingStream,
                        builder: (_, snapshot) {
                          final isPlaying = snapshot.data ?? false;
                          return IconButton(
                            onPressed: currentSongNotifier.togglePlayPause,
                            icon: Icon(
                              isPlaying
                                  ? CupertinoIcons.pause
                                  : CupertinoIcons.play_fill,
                              weight: 700,
                              color: Pallete.whiteColor,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 3,
            child: Container(
              height: 2,
              width: MediaQuery.of(context).size.width - 24,
              decoration: BoxDecoration(
                color: Pallete.inactiveSeekColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          StreamBuilder(
            stream: currentSongNotifier.durationStream,
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              }
              double percentageComplete = 0.0;
              final pos = snapshot.data;
              final duration = currentSongNotifier.duration;
              if (pos != null && duration != null) {
                percentageComplete =
                    pos.inMilliseconds / duration.inMilliseconds;
              }
              final width =
                  (MediaQuery.of(context).size.width - 24) * percentageComplete;
              return Positioned(
                bottom: 0,
                left: 3,
                child: Container(
                  height: 2,
                  width: width,
                  decoration: BoxDecoration(
                    color: Pallete.whiteColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
