import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:workouttemplateapp/all_dialogs.dart';
import 'package:workouttemplateapp/providers/plan_provider.dart';
import 'package:workouttemplateapp/providers/settings_provider.dart';
import 'package:workouttemplateapp/screens/plan_settings_widgets/plan_settings_row.dart';
import 'package:workouttemplateapp/screens/settings_widgets/deletion_type_widget.dart';
import 'package:workouttemplateapp/data/data_models.dart';

class PlanSettingsContent extends ConsumerStatefulWidget {
  final int planPosition;
  final int plansLength;
  const PlanSettingsContent({
    super.key,
    required this.planPosition,
    required this.plansLength,
  });

  @override
  ConsumerState<PlanSettingsContent> createState() => _PlanSettingsListState();
}

class _PlanSettingsListState extends ConsumerState<PlanSettingsContent> {
  final List<bool> checkedPlans = [];

  @override
  void initState() {
    log("init");
    for (var i = 0; i < widget.plansLength; i++) {
      checkedPlans.add(i == widget.planPosition);
      log(checkedPlans.length.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final plans = ref.watch(planProvider);
    final DeletionTypes deletionType = ref.watch(deletionTypeProvider);
    return plans.when(
      data: (plansData) {
        return Column(
          children: [
            Text(
              AppLocalizations.of(context)!.planSettingsDescription,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: ReorderableListView.builder(
                itemCount: plansData!.length,
                itemBuilder: (context, index) {
                  log("build check: ${checkedPlans.length}");
                  log("build plans: ${plansData.length}");
                  if (checkedPlans.length == plansData.length) {
                    return PlanSettingsRow(
                      key: ObjectKey(plansData[index]),
                      title: plansData[index].name,
                      index: index,
                      checked: checkedPlans[index],
                      onCheck: (bool? checked) => onCheck(index, checked),
                    );
                  }
                  return Icon(
                    // TODO: das hier noch schick machen
                    Icons.hourglass_empty,
                    key: ObjectKey(plansData[index]),
                  );
                },
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      --newIndex;
                    }
                    ref
                        .read(planController)
                        .reorderPlans(plansData, oldIndex, newIndex);
                    ref.invalidate(planProvider);

                    final bool tempCheck = checkedPlans[oldIndex];
                    checkedPlans.removeAt(oldIndex);
                    checkedPlans.insert(newIndex, tempCheck);
                  });
                },
              ),
            ),
            //Bottom Bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () => addPlan(ref, plansData, context),
                    style: TextButton.styleFrom(
                      disabledForegroundColor:
                          const Color.fromARGB(255, 150, 150, 150),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.add),
                        Text(AppLocalizations.of(context)!.add),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: allCheckedIndexes(plansData).isNotEmpty
                        ? () => {
                              sharePlans(
                                  plansData, allCheckedIndexes(plansData))
                            }
                        : null,
                    style: TextButton.styleFrom(
                      disabledForegroundColor:
                          const Color.fromARGB(255, 150, 150, 150),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.share),
                        Text(AppLocalizations.of(context)!.share),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: allCheckedIndexes(plansData).isNotEmpty
                        ? () {
                            final List<int> allChecked =
                                allCheckedIndexes(plansData);
                            final String description = allChecked.length == 1
                                ? plansData[allChecked[0]].name
                                : "${allChecked.length} ${AppLocalizations.of(context)!.plans}";
                            deletionType == DeletionTypes.never
                                ? removePlans(allCheckedIndexes(plansData), ref,
                                    plansData)
                                : AllDialogs.showDeleteDialog(
                                    context,
                                    description,
                                    () => {
                                          removePlans(
                                              allCheckedIndexes(plansData),
                                              ref,
                                              plansData)
                                        });
                          }
                        : null,
                    style: TextButton.styleFrom(
                      disabledForegroundColor:
                          const Color.fromARGB(255, 150, 150, 150),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.delete),
                        Text(AppLocalizations.of(context)!.delete),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
      error: (error, _) => Center(
        child: Text(error.toString()),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  List<int> allCheckedIndexes(List<PlanItemData> plans) {
    final List<int> indexList = [];
    for (var i = 0; i < checkedPlans.length; i++) {
      if (checkedPlans[i]) {
        indexList.add(i);
      }
    }
    return indexList;
  }

  removePlans(List<int> indexList, WidgetRef ref, List<PlanItemData> plans) {
    indexList.sort();
    for (var i = indexList.length - 1; i >= 0; i--) {
      checkedPlans.removeAt(indexList[i]);
      ref.read(planController).deletePlan(plans[indexList[i]].id);
      ref.invalidate(planProvider);
    }
  }

  onCheck(int index, bool? checked) {
    setState(() {
      checkedPlans[index] = checked ?? !checkedPlans[index];
    });
  }

  Future<void> addPlan(
      WidgetRef ref, List<PlanItemData> plans, BuildContext context) async {
    final newPlan = PlanItemData(
        name: "NewPlan ${plans.length + 1}", position: plans.length);
    ref.read(planController).addPlan(newPlan);
    ref.invalidate(planProvider);
    checkedPlans.add(false);
  }

  Future<void> sharePlans(
    List<PlanItemData> plans,
    List<int> checkedIndexes,
  ) async {
    final List<XFile> files = [];
    final List<String> planNames = [];
    for (int i = 0; i < plans.length; i++) {
      if (checkedIndexes.contains(i)) {
        final plan = plans[i];
        final Directory tempDir = await getTemporaryDirectory();
        final File file = File(
          "${tempDir.path}/${plan.name.replaceAll(" ", "")}.ptpjson",
        );
        await file.writeAsString(plan.toJson().toString());
        files.add(XFile(file.path));
        planNames.add(plan.name);
      }
    }
    /* final result =
        await Share.shareWithResult('check out my website https://example.com'); */
    await Share.shareXFiles(files);
    /* if (result.status == ShareResultStatus.success) {
      log('Thank you for sharing my website!');
    } */
  }
}
