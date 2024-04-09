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
import 'package:workouttemplateapp/data_models.dart';

class PlanSettingsContent extends ConsumerStatefulWidget {
  final int planId;
  final int planLength;
  const PlanSettingsContent({
    super.key,
    required this.planId,
    required this.planLength,
  });

  @override
  ConsumerState<PlanSettingsContent> createState() => _PlanSettingsListState();
}

class _PlanSettingsListState extends ConsumerState<PlanSettingsContent> {
  final List<bool> checkedPlans = [];

//TODO Anpassen weil planId ist nicht mehr Index
  @override
  void initState() {
    for (var i = 0; i < widget.planLength; i++) {
      checkedPlans.add(i == widget.planId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final plans = ref.watch(planProvider);
    final DeletionTypes deletionType = ref.watch(deletionTypeProvider);
    return plans.when(
      data: (plansData) => Column(
        children: [
          Text(
            AppLocalizations.of(context)!.planSettingsDescription,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: ReorderableListView.builder(
              itemCount: plansData!.length,
              itemBuilder: (context, index) => PlanSettingsRow(
                key: ObjectKey(plansData[index]),
                title: plansData[index].name,
                index: index,
                checked: checkedPlans[index],
                onCheck: (bool? checked) => onCheck(index, checked),
              ),
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) {
                    --newIndex;
                  }
                  ref.read(planController).swapPlans(
                      plansData[newIndex].id, plansData[oldIndex].id);
                  ref.refresh(planProvider.future);
                  //TODO
                  /* final bool tempCheck = checkedPlans[oldIndex];
                  checkedPlans.removeAt(oldIndex);
                  checkedPlans.insert(newIndex, tempCheck); */
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
                      ? () =>
                          {sharePlans(plansData, allCheckedIndexes(plansData))}
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
                              ? removePlans(allCheckedIndexes(plansData), ref)
                              : AllDialogs.showDeleteDialog(
                                  context,
                                  description,
                                  () => {
                                        removePlans(
                                            allCheckedIndexes(plansData), ref)
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
      ),
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
        indexList.add(plans[i].id);
      }
    }
    return indexList;
  }

  removePlans(List<int> indexList, WidgetRef ref) {
    indexList.sort();
    for (var i = indexList.length - 1; i >= 0; i--) {
      ref.read(planController).deletePlan(indexList[i]);
      ref.invalidate(planProvider);
      checkedPlans.removeAt(indexList[i]);
    }
  }

  onCheck(int index, bool? checked) {
    setState(() {
      checkedPlans[index] = checked ?? !checkedPlans[index];
    });
  }

  void addPlan(WidgetRef ref, List<PlanItemData> plans, BuildContext context) {
    const maxPlans = 25;
    if (plans.length < maxPlans) {
      final newPlan = PlanItemData(name: "NewPlan ${plans.length + 1}");
      ref.read(planController).addPlan(newPlan);
      ref.invalidate(planProvider);
      checkedPlans.add(false);
    } else {
      final snackBar = SnackBar(
        content: Text(AppLocalizations.of(context)!.limitReachedPlans(maxPlans),
            textScaler: const TextScaler.linear(1.5)),
        action: SnackBarAction(
          backgroundColor: const Color.fromARGB(255, 255, 235, 150),
          textColor: Colors.black,
          label: 'X',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
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

/*

    <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <data android:scheme="file" />
        <data android:host="*" />
        <data android:pathPattern=".*\\.ptpjson" />
    </intent-filter>
 */