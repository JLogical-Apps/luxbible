import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:lux/lux.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'passage_link_service.g.dart';

class PassageLinkService extends ChangeNotifier {
  static const channel = MethodChannel('app.luxbible.app/passage-link');
  VerseSelection? _selection;

  VerseSelection? get selection => _selection;

  void initialize() {
    channel.setMethodCallHandler((call) async {
      if ((call.method, call.arguments) case ('openPassage', final String link)) open(link);
    });
  }

  Future<void> openLaunchLink() async {
    final link = await channel.invokeMethod<String>('getLaunchLink');
    if (link != null) open(link);
  }

  void open(String link) {
    final uri = Uri.tryParse(link);
    if (uri == null || uri.scheme != 'https' || uri.host != 'app.luxbible.app') return;
    if (uri.pathSegments case ['passage', final osisId]) {
      if (VerseSelection.isOsisId(osisId)) {
        _selection = VerseSelection.fromOsisId(osisId);
        notifyListeners();
      }
    }
  }

  void clearSelection() {
    _selection = null;
    notifyListeners();
  }
}

@Riverpod(keepAlive: true)
PassageLinkService passageLinkService(Ref ref) => PassageLinkService();
