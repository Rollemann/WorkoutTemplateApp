import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/providers/shared_preference_provider.dart';
import 'package:workouttemplateapp/screens/settings_widgets/deletion_type_widget.dart';

final lightModeProvider = StateProvider<bool>((ref) {
  final bool systemIsLightMode =
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.light;
  final preferences = ref.watch(sharedPreferencesProvider);
  final lightMode = preferences.getBool('lightMode') ?? systemIsLightMode;
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

final showHintsProvider = StateProvider<bool>((ref) {
  final preferences = ref.watch(sharedPreferencesProvider);
  final showHints = preferences.getBool('showHints') ?? true;
  ref.listenSelf((prev, curr) {
    preferences.setBool('showHints', curr);
  });
  return showHints;
});

final languageProvider = StateProvider<String>((ref) {
  final preferences = ref.watch(sharedPreferencesProvider);
  final language = preferences.getString('language') ?? "en";
  ref.listenSelf((prev, curr) {
    preferences.setString('language', curr);
  });
  return language;
});

final soundProvider = StateProvider<String>((ref) {
  final preferences = ref.watch(sharedPreferencesProvider);
  final sound = preferences.getString('sound') ?? "ring01.mp3";
  ref.listenSelf((prev, curr) {
    preferences.setString('sound', curr);
  });
  return sound;
});
