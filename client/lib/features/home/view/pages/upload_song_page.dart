import 'package:client/core/utils.dart';
import 'package:client/core/widgets/generic_text_field.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/home/view/widgets/my_color_picker.dart';
import 'package:client/features/home/view/widgets/upload_audio.dart';
import 'package:client/features/home/view/widgets/upload_image.dart';
import 'package:client/features/home/viewmodel/home_viewmodel.dart';
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
  late final _formKey;
  @override
  void initState() {
    _name = TextEditingController();
    _artist = TextEditingController();
    _formKey = GlobalKey<FormState>();
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
    final isLoading = ref.watch(
      homeViewModelProvider.select((val) => val?.isLoading == true),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Song Upload Page"),
        actions: [
          IconButton(
            onPressed: () async {
              final selectedSong = ref
                  .read(audioNotifierProvider.notifier)
                  .state;
              final selectedImage = ref
                  .read(imageNotifierProvider.notifier)
                  .state;
              if (_formKey.currentState!.validate() &&
                  selectedImage != null &&
                  selectedSong != null) {
                ref
                    .read(homeViewModelProvider.notifier)
                    .uploadSong(
                      selectedAudio: selectedSong,
                      selectedImage: selectedImage,
                      artist: _artist.text,
                      songName: _name.text,
                      color: ref.read(colorPickerProvider.notifier).state,
                    );
              } else {
                showSnackBar(context, "Missing Fields");
              }
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: isLoading
          ? Loader()
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Form(
                  key: _formKey,
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
            ),
    );
  }
}
