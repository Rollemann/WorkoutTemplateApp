import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workouttemplateapp/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/dbHandler.dart';

//final lightModeProviderd = StateProvider((ref) => true);
final deletionConfirmationProvider =
    StateProvider((ref) => DeletionTypes.always);

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




/* class FavoriteIds extends StateNotifier<List<String>> {
  FavoriteIds(this.pref) : super(pref?.getStringList("id") ?? []);

  static final provider = StateNotifierProvider<FavoriteIds, List<String>>((ref) {
    final pref = ref.watch(sharedPrefs).maybeWhen(
          data: (value) => value,
          orElse: () => null,
        );
    return FavoriteIds(pref);
  });

  final SharedPreferences? pref;

  void toggle(String favoriteId) {
    if (state.contains(favoriteId)) {
      state = state.where((id) => id != favoriteId).toList();
    } else {
      state = [...state, favoriteId];
    }
    // Throw here since for some reason SharedPreferences could not be retrieved
    pref!.setStringList("id", state);
  }
} */