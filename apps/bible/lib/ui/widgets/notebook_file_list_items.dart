import 'package:bible/models/notebook.dart';
import 'package:bible/models/notebook_file.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/services/notebook_file_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:share_plus/share_plus.dart';
import 'package:style/style.dart';

class NotebookShareListItem extends ConsumerWidget {
  final Notebook? notebook;

  const NotebookShareListItem({super.key, required this.notebook});

  @override
  Widget build(BuildContext context, WidgetRef ref) => StyledListItem(
    leading: Symbols.ios_share.toIcon(),
    title: t.notebookUi.share.toText(),
    subtitle: t.notebookUi.shareDescription.toText(),
    onPressed: () async {
      final renderObject = context.findRenderObject();
      final origin = renderObject is RenderBox ? renderObject.localToGlobal(.zero) & renderObject.size : null;
      final file = NotebookFile.fromUser(ref.read(userProvider), notebook: notebook);
      context.pop();

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile.fromData(NotebookFileService.getBytes(file), mimeType: NotebookFileService.mimeType)],
          fileNameOverrides: [NotebookFileService.getFilename(file.name)],
          title: file.name,
          sharePositionOrigin: origin,
        ),
      );
    },
  );
}

class NotebookDownloadListItem extends ConsumerWidget {
  final Notebook? notebook;

  const NotebookDownloadListItem({super.key, required this.notebook});

  @override
  Widget build(BuildContext context, WidgetRef ref) => StyledListItem(
    leading: Symbols.download.toIcon(),
    title: t.notebookUi.download.toText(),
    subtitle: t.notebookUi.downloadDescription.toText(),
    onPressed: () async {
      final file = NotebookFile.fromUser(ref.read(userProvider), notebook: notebook);
      context.pop();

      try {
        await FlutterFileSaver().writeFileAsBytes(
          fileName: NotebookFileService.getFilename(file.name),
          bytes: NotebookFileService.getBytes(file),
        );
      } on FileSaverCancelledException {
        return;
      }
    },
  );
}
