import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/dataModel.dart';
import 'package:workouttemplateapp/providers/planProvider.dart';
//import 'package:great_list_view/great_list_view.dart';
import 'package:workouttemplateapp/screens/mainWidgets/templateRow.dart';
import 'package:workouttemplateapp/screens/mainWidgets/templateSettings.dart';

final List<String> rowTypes = ["Reps", "Time", "Pause"];

class TemplateDetails extends ConsumerStatefulWidget {
  final int id;
  final Function renameTab;
  const TemplateDetails({
    super.key,
    required this.id,
    required this.renameTab,
  });

  @override
  ConsumerState<TemplateDetails> createState() => _TemplateDetailsState();
}

class _TemplateDetailsState extends ConsumerState<TemplateDetails> {
  //final controller = AnimatedListController();

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
                final row = plans[widget.id].rows.removeAt(oldIndex);
                plans[widget.id].rows.insert(newIndex, row);
              });
            },
            itemBuilder: (context, index) => TemplateRow(
              key: ObjectKey(plans[widget.id].rows[index]),
              tabID: widget.id,
              rowID: index,
            ),
            //animation: animation,
          ),
        ),
        TemplateSettings(
          renameTab: widget.renameTab,
          currentTabId: widget.id,
        ),
      ],
    );
  }
}
