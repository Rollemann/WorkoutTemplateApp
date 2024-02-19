import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/providers/settings_provider.dart';
import 'package:workouttemplateapp/screens/main_screen.dart';

const evenLight = Color.fromARGB(255, 170, 170, 170);
const oddLight = Color.fromARGB(255, 210, 210, 210);
const evenDark = Color.fromARGB(255, 70, 70, 70);
const oddDark = Color.fromARGB(255, 97, 97, 97);

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
      primaryContainer: const Color.fromARGB(255, 201, 226, 250),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: MaterialStateProperty.all(const BorderSide(
          width: 2,
          color: Colors.black,
        )),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.black),
    ),
  );

  final ThemeData myDarkMode = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      primaryContainer: const Color.fromARGB(255, 0, 97, 164),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(
          width: 2,
          color: Colors.white,
        ),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.white),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 105, 185, 250)),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Color.fromARGB(255, 105, 185, 250),
      selectionHandleColor: Color.fromARGB(255, 105, 185, 250),
      selectionColor: Color.fromARGB(255, 0, 140, 255),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.white,
      textColor: Colors.white,
    ),
    checkboxTheme: CheckboxThemeData(
      side: MaterialStateBorderSide.resolveWith(
        (states) => const BorderSide(width: 2.0, color: Colors.white),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final bool lightMode = ref.watch(lightModeProvider);
    final String language = ref.watch(languageProvider);
    return MaterialApp(
      title: 'Workout APP',
      theme: myLightMode,
      darkTheme: myDarkMode,
      themeMode: lightMode ? ThemeMode.light : ThemeMode.dark,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
        Locale('de'), // German
      ],
      locale: Locale.fromSubtags(languageCode: language),
      home: const MainScreen(),
    );
  }
}


/* TODO

- Settings:
  - Donations

- Pläne teilen über verschiedene Kanäle (extra Fenster wo man anhaken kann welche)
- Pläne auch wieder öffnen können mit der App.
- Ton / Vibration wenn Timer Ende ist

- Style alles (Tag / Nacht Modus) alles nochmal checken
- raus mit der special liste (reorder und animation)
- Alle übersetzungen checken


(- Verschiedene Farben als Themes)
(- Verschiedene Farben für verschiedene Pläne)
(- Animation beim löschen und hinzugfügen von Rows)
(Room (Floor) statt shared prefs)
(Wenn Zeit ende: Lied anhalten oder so (Wiedergabe stoppen))

 */