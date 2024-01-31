import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/providers/sharedPreferenceProvider.dart';
import 'package:workouttemplateapp/screens/settingsWidgets/deletionTypeWidget.dart';

final lightModeProvider = StateProvider<bool>((ref) {
  final preferences = ref.watch(sharedPreferencesProvider);
  final lightMode = preferences.getBool('lightMode') ?? true;
  ref.listenSelf((prev, curr) {
    preferences.setBool('lightMode', curr);
  });
  return lightMode;
});

final deletionTypeProvider = StateProvider<DeletionTypes>((ref) {
  final preferences = ref.watch(sharedPreferencesProvider);
  final deletionTypeString = preferences.getString('deletionType') ?? "always";
  ref.listenSelf((prev, curr) {
    final String currString;
    if (curr == DeletionTypes.always) {
      currString = "always";
    } else if (curr == DeletionTypes.plans) {
      currString = "plans";
    } else {
      currString = "never";
    }
    preferences.setString('deletionType', currString);
  });

  if (deletionTypeString == "always") {
    return DeletionTypes.always;
  }
  if (deletionTypeString == "plans") {
    return DeletionTypes.plans;
  }
  return DeletionTypes.never;
});

final vibrationProvider = StateProvider<bool>((ref) {
  final preferences = ref.watch(sharedPreferencesProvider);
  final vibration = preferences.getBool('vibration') ?? true;
  ref.listenSelf((prev, curr) {
    preferences.setBool('vibration', curr);
  });
  return vibration;
});

final volumeProvider = StateProvider<double>((ref) {
  final preferences = ref.watch(sharedPreferencesProvider);
  final volume = preferences.getDouble('volume') ?? 50;
  ref.listenSelf((prev, curr) {
    preferences.setDouble('volume', curr);
  });
  return volume;
});
