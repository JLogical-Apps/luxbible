import 'package:bible/main.dart';
import 'package:bible/services/analytics_service.dart';
import 'package:bible/services/launch_link_channel.dart';
import 'package:bible/ui/pages/notebooks_page.dart';
import 'package:bible/ui/sheets/notebook_import_sheet.dart';
import 'package:lux/lux.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notebook_open_service.g.dart';

class NotebookOpenService {
  static final channel = LaunchLinkChannel(
    'app.luxbible.app/notebook-open',
    launchMethod: 'getLaunchNotebook',
    openMethod: 'openNotebook',
  );

  void initialize() => channel.listen(openContents);

  Future<void> openLaunchNotebook() async {
    if (await channel.getLaunchValue() case final contents?) openContents(contents, isLaunch: true);
  }

  void openContents(String contents, {bool isLaunch = false}) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    AnalyticsEvent.notebookFileOpened.log();

    if (isLaunch) {
      context.goToRoot(
        pages: [NotebooksPage()],
        onLoaded: (context) => NotebookImportSheet.showForContents(context, contents),
      );
    } else {
      NotebookImportSheet.showForContents(context, contents);
    }
  }
}

@Riverpod(keepAlive: true)
NotebookOpenService notebookOpenService(Ref ref) => NotebookOpenService();
