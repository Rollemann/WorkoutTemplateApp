import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/template_data_models.dart';
import 'package:workouttemplateapp/providers/plan_provider.dart';
import 'package:workouttemplateapp/screens/main_widgets/template_row.dart';
import 'package:workouttemplateapp/screens/main_widgets/template_settings.dart';

final List<String> rowTypes = ["Reps", "Time", "Pause"];

class TemplateDetails extends ConsumerStatefulWidget {
  final int id;
  const TemplateDetails({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<TemplateDetails> createState() => _TemplateDetailsState();
}

class _TemplateDetailsState extends ConsumerState<TemplateDetails> {
  @override
  Widget build(BuildContext context) {
    final List<PlanItemData> plans = ref.watch(planProvider);
    return Column(
      children: [
        Expanded(
          child: ReorderableListView.builder(
            itemCount: plans[widget.id].rows.length,
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) {
                  --newIndex;
                }
                final row = ref
                    .read(planProvider.notifier)
                    .removeRow(widget.id, oldIndex);
                ref
                    .read(planProvider.notifier)
                    .addRow(widget.id, row, newIndex);
              });
            },
            itemBuilder: (context, index) => TemplateRow(
              key: ObjectKey(plans[widget.id].rows[index]),
              tabID: widget.id,
              rowID: index,
            ),
          ),
        ),
        TemplateSettings(
          currentTabId: widget.id,
        ),
      ],
    );
  }
}
