import 'dart:io';
import 'package:client/core/theme/app_palette.dart';
import 'package:client/core/utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class UploadImage extends ConsumerStatefulWidget {
  const UploadImage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadImageState();
}

final imageNotifierProvider = StateProvider<File?>((_) => null);

class _UploadImageState extends ConsumerState<UploadImage> {
  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      ref.read(imageNotifierProvider.notifier).state = pickedImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pickedImage = ref.watch(imageNotifierProvider);
    return GestureDetector(
      onTap: selectImage,
      child: pickedImage != null
          ? SizedBox(
              height: 168,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.file(pickedImage, fit: BoxFit.cover),
              ),
            )
          : const DottedBorder(
              options: RoundedRectDottedBorderOptions(
                color: Pallete.borderColor,
                dashPattern: [10, 8],
                radius: Radius.circular(10),
              ),
              child: SizedBox(
                height: 150,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.folder_open, size: 40),
                    SizedBox(height: 15),
                    Text("Select a thumbnail", style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ),
    );
  }
}
