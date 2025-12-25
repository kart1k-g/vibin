import 'dart:io';
import 'package:client/core/utils.dart';
import 'package:client/core/widgets/generic_text_field.dart';
import 'package:client/features/home/view/widgets/audio_wave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final audioNotifierProvider = StateProvider<File?>((_) => null);

class UploadAudio extends ConsumerWidget {
  const UploadAudio({super.key});

  void selectAudio(WidgetRef ref) async {
    final pickedAudio = await pickAudio();
    if (pickedAudio != null) {
      ref.read(audioNotifierProvider.notifier).state = pickedAudio;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickedAudio = ref.watch(audioNotifierProvider);
    return pickedAudio != null
        ? AudioWave(audioPath: pickedAudio.path)
        : GenericTextField(
            hintText: "Pick a song",
            readOnly: true,
            onTap: () => selectAudio(ref),
          );
  }
}
