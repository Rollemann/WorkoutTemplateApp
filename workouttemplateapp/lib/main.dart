import 'package:flutter/material.dart';
import 'package:workouttemplateapp/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/dbHandler.dart';

final lightModeProvider = StateProvider((ref) => true);
final deletionConfirmationProvider =
    StateProvider((ref) => DeletionConfirmationTypes.always);

void main() {
  runApp(const ProviderScope(child: App()));
}
