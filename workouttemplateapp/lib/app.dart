import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/providers/settings_provider.dart';
import 'package:workouttemplateapp/screens/main_screen.dart';

const evenLight = Color.fromARGB(255, 210, 210, 210);
const oddLight = Color.fromARGB(255, 230, 230, 230);
const evenDark = Color.fromARGB(255, 50, 50, 50);
const oddDark = Color.fromARGB(255, 70, 70, 70);
const onEvenLight = Color.fromARGB(255, 240, 240, 240);
const onOddLight = Color.fromARGB(255, 200, 200, 200);
const onEvenDark = Color.fromARGB(255, 90, 90, 90);
const onOddDark = Color.fromARGB(255, 105, 105, 105);

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
      primaryContainer: Colors.transparent,
      secondaryContainer: const Color.fromARGB(235, 255, 255, 255),
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
      primaryContainer: Colors.transparent,
      secondaryContainer: const Color.fromARGB(235, 0, 0, 0),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
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
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(Colors.white),
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
    tabBarTheme: const TabBarTheme(
      unselectedLabelColor: Color.fromARGB(255, 130, 130, 130),
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

- Ton wenn Timer Ende ist

- scroll down wenn man ein element edit macht
- Pläne teilen über verschiedene Kanäle (extra Fenster wo man anhaken kann welche)
- Pläne auch wieder öffnen können mit der App.

- Style alles (Tag / Nacht Modus) alles nochmal checken
- Alle übersetzungen checken
- Beschreibungen der Settings checken
- Name und Icon für die App

(- Verschiedene Farben als Themes)
(- Verschiedene Farben für verschiedene Pläne)
(- Animation beim löschen und hinzugfügen von Rows)
(Room (Floor) statt shared prefs)
(Wenn Zeit ende: Lied anhalten oder so (Wiedergabe stoppen))

 */