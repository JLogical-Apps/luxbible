import 'package:bible/models/bible_plan.dart';
import 'package:bible/services/bible_plan_file_service.dart';
import 'package:bible/ui/sheets/bible_plan_export_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:share_plus/share_plus.dart';
import 'package:style/style.dart';

class BiblePlanShareListItem extends StatelessWidget {
  final String planId;
  final BiblePlan plan;
  final BiblePlanProgress? progress;

  const BiblePlanShareListItem({super.key, required this.planId, required this.plan, this.progress});

  @override
  Widget build(BuildContext context) => StyledListItem(
    leading: Symbols.ios_share.toIcon(),
    title: t.biblePlans.share.toText(),
    subtitle: t.biblePlans.shareDescription.toText(),
    onPressed: () async {
      final renderObject = context.findRenderObject();
      final origin = renderObject is RenderBox ? renderObject.localToGlobal(.zero) & renderObject.size : null;
      final displayName = plan.getDisplayName(planId);
      final filename = BiblePlanFileService.getFilename(displayName);
      final rootContext = context.rootContext;
      context.pop();

      final file = await BiblePlanExportSheet.show(
        rootContext,
        title: t.biblePlans.share,
        planId: planId,
        plan: plan,
        progress: progress,
      );
      if (file == null) return;

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile.fromData(BiblePlanFileService.getBytes(file), mimeType: BiblePlanFileService.mimeType)],
          fileNameOverrides: [filename],
          title: displayName,
          sharePositionOrigin: origin,
        ),
      );
    },
  );
}

class BiblePlanDownloadListItem extends StatelessWidget {
  final String planId;
  final BiblePlan plan;
  final BiblePlanProgress? progress;

  const BiblePlanDownloadListItem({super.key, required this.planId, required this.plan, this.progress});

  @override
  Widget build(BuildContext context) => StyledListItem(
    leading: Symbols.download.toIcon(),
    title: t.biblePlans.download.toText(),
    subtitle: t.biblePlans.downloadDescription.toText(),
    onPressed: () async {
      final rootContext = context.rootContext;
      context.pop();

      final file = await BiblePlanExportSheet.show(
        rootContext,
        title: t.biblePlans.download,
        planId: planId,
        plan: plan,
        progress: progress,
      );
      if (file == null) return;

      try {
        await FlutterFileSaver().writeFileAsBytes(
          fileName: BiblePlanFileService.getFilename(plan.getDisplayName(planId)),
          bytes: BiblePlanFileService.getBytes(file),
        );
      } on FileSaverCancelledException {
        return;
      }
    },
  );
}
