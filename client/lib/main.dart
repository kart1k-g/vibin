import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/theme/app_theme.dart';
import 'package:client/features/auth/repository/auth_local_repository.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:client/features/home/view/pages/home_view.dart';
import 'package:client/features/home/view/pages/upload_song_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  final authLocalRepository = await AuthLocalRepository.init();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  await Hive.openBox('songs');
  runApp(
    ProviderScope(
      overrides: [
        authLocalRepositoryProvider.overrideWithValue(authLocalRepository),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initView = ref.watch(currentUserProvider) == null
        ? LoginPage()
        : HomeView();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vibin Music App',
      theme: AppTheme.darkThemeMode,
      home: initView ,
    );
  }
}
