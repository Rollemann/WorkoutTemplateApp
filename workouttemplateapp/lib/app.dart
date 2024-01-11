import 'package:flutter/material.dart';
import 'package:workouttemplateapp/screens/mainScreen.dart';

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
      home: MainScreen(),
    );
  }
}


/* TODO
- Rows:
  - Row für Pause
  - Row für Exercise auf Zeit
  (- Animation beim löschen und hinzugfügen von Rows)
  - Popup wo Zeit läuft?

- Daten persistent speichern
- Anzahl Pläne und Reihen beschränken
- Extra Fenster zum Pläne in der Reihenfolge zu ändern.

- Pläne teilen über verschiedene Kanäle (extra Fenster wo man anhaken kann welche)
- Pläne auch wieder öffnen können mit der App.

- Settings: 
  - Settings Knopf in Appbar
  - Settingsseite
  - Donations
  - Tag/Nacht Modus
  - Ton / Vibration wenn Timer Ende ist
  (- Confirm Deletion ein und ausschlaten können)



 */