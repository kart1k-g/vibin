import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/theme/app_theme.dart';
import 'package:client/features/auth/repository/auth_local_repository.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:client/features/home/view/pages/home_view.dart';
import 'package:client/features/home/view/pages/upload_song_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authLocalRepository = await AuthLocalRepository.init();
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
      home: UploadSongPage(),
    );
  }
}
