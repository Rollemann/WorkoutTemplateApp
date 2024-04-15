import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:workouttemplateapp/data/data_models.dart';
import 'package:workouttemplateapp/providers/plan_provider.dart';
import 'package:workouttemplateapp/screens/main_widgets/plan_row.dart';
import 'package:workouttemplateapp/screens/main_widgets/plan_bottom_bar.dart';

class PlanDetails extends ConsumerStatefulWidget {
  final PlanItemData plan;
  final int plansLength;
  const PlanDetails({
    super.key,
    required this.plan,
    required this.plansLength,
  });

  @override
  ConsumerState<PlanDetails> createState() => _PlanDetailsState();
}

class _PlanDetailsState extends ConsumerState<PlanDetails> {
  /* late StreamSubscription _intentSub;
  final _sharedFiles = <SharedMediaFile>[];
  
  @override
  void initState() {
    super.initState();
    // Listen to media sharing coming from outside the app while the app is in the memory.
    var _intentSub = ReceiveSharingIntent.getMediaStream().listen((value) {
      setState(() {
        _sharedFiles.clear();
        _sharedFiles.addAll(value);

        log((_sharedFiles.map((f) => f.toMap())).toString());
      });
    }, onError: (err) {
      log(("getIntentDataStream error: $err").toString());
    });

    // Get the media sharing coming from outside the app while the app is closed.
    ReceiveSharingIntent.getInitialMedia().then((value) {
      setState(() {
        _sharedFiles.clear();
        _sharedFiles.addAll(value);
        log((_sharedFiles.map((f) => f.toMap())).toString());

        // Tell the library that we are done processing the intent.
        ReceiveSharingIntent.reset();
      });
    });
  }

  @override
  void dispose() {
    _intentSub.cancel();
    super.dispose();
  } */

  @override
  Widget build(BuildContext context) {
    final rows = ref.watch(rowProvider);
    return rows.when(
      data: (rowData) {
        final planRows =
            rowData!.where((row) => row.planId == widget.plan.id).toList();
        return Column(
          children: [
            Expanded(
              child: ReorderableListView.builder(
                itemCount: planRows.length,
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      --newIndex;
                    }
                    ref
                        .read(rowController)
                        .reorderRows(planRows, oldIndex, newIndex);
                    ref.invalidate(rowProvider);
                  });
                },
                itemBuilder: (context, index) => Column(
                  key: ObjectKey(planRows[index]),
                  children: [
                    PlanRow(
                      planId: widget.plan.id,
                      rowId: planRows[index].id,
                    ),
                    const Divider(
                      indent: 25,
                      endIndent: 25,
                    )
                  ],
                ),
              ),
            ),
            PlanBottomBar(
              plan: widget.plan,
              plansLength: widget.plansLength,
            ),
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
}
