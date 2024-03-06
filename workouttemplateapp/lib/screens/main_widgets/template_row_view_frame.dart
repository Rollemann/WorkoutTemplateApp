import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/app.dart';
import 'package:workouttemplateapp/providers/settings_provider.dart';

class TemplateRowViewFrame extends ConsumerStatefulWidget {
  final Widget child;
  final int rowID;
  final Function onEdit;
  final bool rowChecked;
  final Function toggleRowChecked;

  const TemplateRowViewFrame({
    super.key,
    required this.child,
    required this.rowID,
    required this.onEdit,
    required this.rowChecked,
    required this.toggleRowChecked,
  });

  @override
  ConsumerState<TemplateRowViewFrame> createState() =>
      _TemplateRowViewFrameState();
}

class _TemplateRowViewFrameState extends ConsumerState<TemplateRowViewFrame> {
  @override
  Widget build(BuildContext context) {
    final lightMode = ref.watch(lightModeProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.5, horizontal: 3),
      child: GestureDetector(
        onTap: () {
          widget.toggleRowChecked();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: lightMode
                ? widget.rowChecked
                    ? const Color.fromARGB(255, 0, 145, 5)
                    : widget.rowID % 2 == 0
                        ? evenLight
                        : oddLight
                : widget.rowChecked
                    ? const Color.fromARGB(255, 1, 100, 5)
                    : widget.rowID % 2 == 0
                        ? evenDark
                        : oddDark,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.drag_handle,
                ),
                widget.child,
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    tooltip: AppLocalizations.of(context)!.edit,
                    onPressed: () => widget.onEdit(),
                    style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(CircleBorder()),
                    ),
                    icon: const Icon(Icons.edit),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
