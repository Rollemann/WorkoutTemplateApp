import 'package:flutter/material.dart';
import 'package:workouttemplateapp/screens/main_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      home: const MainScreen(),
    );
  }
}


/* TODO

- Style alles

(- Animation beim löschen und hinzugfügen von Rows)

- Extra Fenster zum Pläne in der Reihenfolge zu ändern.

- Pläne teilen über verschiedene Kanäle (extra Fenster wo man anhaken kann welche)
- Pläne auch wieder öffnen können mit der App.

- Settings: 
  - Donations
  - Tag/Nacht Modus
  - Ton / Vibration wenn Timer Ende ist

(Sprachen)
(Wenn Zeit ende: Lied anhalten oder so (Wiedergabe stoppen))

 */