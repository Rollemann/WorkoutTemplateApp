import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/providers/settings_provider.dart';
import 'package:workouttemplateapp/screens/main_screen.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  final ThemeData myLightMode = ThemeData.light().copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        outlineVariant: const Color.fromARGB(255, 120, 120, 120),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ));
  final ThemeData myDarkMode = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final bool lightMode = ref.watch(lightModeProvider);
    return MaterialApp(
      title: 'Workout APP',
      theme: myLightMode,
      darkTheme: myDarkMode,
      themeMode: lightMode ? ThemeMode.light : ThemeMode.dark,
      home: const MainScreen(),
    );
  }
}


/* TODO

- Style alles (Tag / Nacht Modus)
- Extra Fenster zum Pläne in der Reihenfolge zu ändern.
- Verschiedene Farben als Themes

- Settings: 
  - Donations
  - Sprachen

- Pläne teilen über verschiedene Kanäle (extra Fenster wo man anhaken kann welche)
- Pläne auch wieder öffnen können mit der App.
- Ton / Vibration wenn Timer Ende ist

- Donations einrichten

(- Animation beim löschen und hinzugfügen von Rows)
(Room (Floor) statt shared prefs)
(Wenn Zeit ende: Lied anhalten oder so (Wiedergabe stoppen))

 */