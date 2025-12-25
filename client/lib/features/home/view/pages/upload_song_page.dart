import 'package:client/core/widgets/generic_text_field.dart';
import 'package:client/features/home/view/widgets/my_color_picker.dart';
import 'package:client/features/home/view/widgets/upload_audio.dart';
import 'package:client/features/home/view/widgets/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadSongPageState();
}


class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  late final TextEditingController _name;
  late final TextEditingController _artist;
  @override
  void initState() {
    _name = TextEditingController();
    _artist = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _artist.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Song Upload Page"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.check))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            children: [
              const UploadImage(),
              const SizedBox(height: 40),
              const UploadAudio(),
              const SizedBox(height: 18),
              GenericTextField(hintText: "Name", controller: _name),
              const SizedBox(height: 18),
              GenericTextField(hintText: "Artist", controller: _artist),
              const SizedBox(height: 18),
              const MyColorPicker(),
            ],
          ),
        ),
      ),
    );
  }
}
