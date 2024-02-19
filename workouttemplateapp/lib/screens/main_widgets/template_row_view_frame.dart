import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/app.dart';
import 'package:workouttemplateapp/providers/settings_provider.dart';

class TemplateRowViewFrame extends ConsumerStatefulWidget {
  final Widget child;
  final int rowID;
  final Function onEdit;

  const TemplateRowViewFrame({
    super.key,
    required this.child,
    required this.rowID,
    required this.onEdit,
  });

  @override
  ConsumerState<TemplateRowViewFrame> createState() =>
      _TemplateRowViewFrameState();
}

class _TemplateRowViewFrameState extends ConsumerState<TemplateRowViewFrame> {
  bool rowChecked = false;

  @override
  Widget build(BuildContext context) {
    final lightMode = ref.watch(lightModeProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.5),
      child: GestureDetector(
        onTap: () {
          setState(() {
            rowChecked = !rowChecked;
          });
        },
        child: Container(
          color: lightMode
              ? rowChecked
                  ? const Color.fromARGB(255, 0, 145, 5)
                  : widget.rowID % 2 == 0
                      ? evenLight
                      : oddLight
              : rowChecked
                  ? const Color.fromARGB(255, 1, 100, 5)
                  : widget.rowID % 2 == 0
                      ? evenDark
                      : oddDark,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.drag_handle,
                ),
                widget.child,
                ElevatedButton(
                  onPressed: () {}, //widget.onEdit(),
                  style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(CircleBorder()),
                  ),
                  child: const Icon(Icons.edit),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
