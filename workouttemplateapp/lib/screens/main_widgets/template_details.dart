import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:workouttemplateapp/data_models.dart';
import 'package:workouttemplateapp/providers/plan_provider.dart';
import 'package:workouttemplateapp/screens/main_widgets/template_row.dart';
import 'package:workouttemplateapp/screens/main_widgets/template_settings.dart';

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
    final rows = ref.watch(getRowController);
    return rows.when(
      data: (rowData) {
        final curRowData =
            rowData!.where((row) => row.planId == widget.id).toList();
        return Column(
          children: [
            Expanded(
              child: ReorderableListView.builder(
                itemCount: curRowData.length,
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      --newIndex;
                    }
                    ref.read(rowController).swapRows(newIndex, oldIndex);
                    ref.refresh(getRowController.future);
                  });
                },
                itemBuilder: (context, index) => Column(
                  key: ObjectKey(curRowData[index]),
                  children: [
                    TemplateRow(
                      tabID: widget.id,
                      rowID: index,
                    ),
                    const Divider(
                      indent: 25,
                      endIndent: 25,
                    )
                  ],
                ),
              ),
            ),
            TemplateSettings(
              currentTabId: widget.id,
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
