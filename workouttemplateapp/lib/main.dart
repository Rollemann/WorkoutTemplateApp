import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workouttemplateapp/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/providers/shared_preference_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const App(),
    ),
  );
}
