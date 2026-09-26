import 'package:bible/models/bible_plan.dart';
import 'package:bible/services/bible_plan_file_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:share_plus/share_plus.dart';
import 'package:style/style.dart';

class BiblePlanShareListItem extends StatelessWidget {
  final BiblePlan plan;
  final String displayName;

  const BiblePlanShareListItem({super.key, required this.plan, required this.displayName});

  @override
  Widget build(BuildContext context) => StyledListItem(
    leading: Symbols.ios_share.toIcon(),
    title: t.biblePlans.share.toText(),
    subtitle: t.biblePlans.shareDescription.toText(),
    onPressed: () async {
      final renderObject = context.findRenderObject();
      final origin = renderObject is RenderBox ? renderObject.localToGlobal(.zero) & renderObject.size : null;
      final filename = BiblePlanFileService.getFilename(displayName);
      context.pop();
      await SharePlus.instance.share(
        ShareParams(
          files: [
            XFile.fromData(
              BiblePlanFileService.getBytes(plan, displayName: displayName),
              mimeType: BiblePlanFileService.mimeType,
            ),
          ],
          fileNameOverrides: [filename],
          title: displayName,
          sharePositionOrigin: origin,
        ),
      );
    },
  );
}

class BiblePlanDownloadListItem extends StatelessWidget {
  final BiblePlan plan;
  final String displayName;

  const BiblePlanDownloadListItem({super.key, required this.plan, required this.displayName});

  @override
  Widget build(BuildContext context) => StyledListItem(
    leading: Symbols.download.toIcon(),
    title: t.biblePlans.download.toText(),
    subtitle: t.biblePlans.downloadDescription.toText(),
    onPressed: () async {
      context.pop();
      try {
        await FlutterFileSaver().writeFileAsBytes(
          fileName: BiblePlanFileService.getFilename(displayName),
          bytes: BiblePlanFileService.getBytes(plan, displayName: displayName),
        );
      } on FileSaverCancelledException {
        return;
      }
    },
  );
}
