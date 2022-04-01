import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_theme_mode/woo_theme_mode.dart';
import 'package:woopear/utils/config/routes.dart';
import 'package:woopear/utils/config/theme/theme.dart';
import 'package:woopear/utils/fire/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      debugShowCheckedModeBanner: false,
      title: 'Woopear',
      // utilisation du context pour recuperer
      // le themeMode qui ce charge de modifier votre theme
      // via votre bouton switch ou du theme du systeme 
      themeMode: ref.watch(wooThemeChange).themeMode,
      // nom de votre variable dans le fichier themes.dart
      theme: themeClaire,
      // nom de votre variable dans le fichier themes.dart
      darkTheme: themeDark,
      initialRoute: Routes().home,
      routes: Routes().urls(),
    );
  }
}
