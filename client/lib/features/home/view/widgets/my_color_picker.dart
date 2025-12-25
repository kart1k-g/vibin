import 'package:client/core/theme/app_palette.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final paletterColorProvider = StateProvider<Color>((_) => Pallete.cardColor);

class MyColorPicker extends ConsumerWidget {
  const MyColorPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ColorPicker(
      pickersEnabled: {ColorPickerType.wheel: true},
      color: ref.read(paletterColorProvider.notifier).state,
      onColorChanged: (Color color) {
        ref.read(paletterColorProvider.notifier).state = color;
      },
    );
  }
}
