import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_theme_mode/woo_theme_mode.dart';
import 'package:woopear/utils/config/routes.dart';
import 'package:woopear/utils/config/theme/theme.dart';
import 'package:woopear/utils/constants/globals.dart';
import 'package:woopear/utils/fire/firebase_options.dart';

void main() async {
  /// pour les widgets android
  WidgetsFlutterBinding.ensureInitialized();
  /// init firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /// entrer de l'appli
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerStatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, /// pas de banniere debug
      title: Globals.titleApp,
      themeMode: ref.watch(wooThemeChange).themeMode,
      theme: themeClaire,
      darkTheme: themeDark,
      initialRoute: Routes().home,
      routes: Routes().urls(),
    );
  }
}
