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
States: 
- Tabs (Namen AS, Position AS, deleted AS, Liste mit Rows AS)
- Rows (intere Daten AS, für Details und rows, editable ist ES)
- LightMode (An oder aus) AS
- Deletion Confirmation AS
- Vibration AS
- Volume AS


- Rows:
  - Hint für Double Tap um Timer zu starten
  (- Animation beim löschen und hinzugfügen von Rows)

- Daten persistent speichern
- Anzahl Pläne und Reihen beschränken und text input Länge
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