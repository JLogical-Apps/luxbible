import 'package:bible/services/bible_navigation_service.dart';
import 'package:bible/services/launch_link_channel.dart';
import 'package:lux/lux.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'passage_link_service.g.dart';

class PassageLinkService {
  static final channel = LaunchLinkChannel(
    'app.luxbible.app/passage-link',
    launchMethod: 'getLaunchLink',
    openMethod: 'openPassage',
  );

  final BibleNavigationService navigation;

  PassageLinkService({required this.navigation});

  void initialize() => channel.listen(open);

  Future<void> openLaunchLink() async {
    if (await channel.getLaunchValue() case final link?) open(link);
  }

  void open(String link) {
    if (Uri.tryParse(link) case final uri? when uri.scheme == 'https' && uri.host == 'app.luxbible.app') {
      if (uri.pathSegments case ['passage', final osisId] when VerseSelection.isOsisId(osisId)) {
        navigation.navigateTo(VerseSelection.fromOsisId(osisId));
      }
    }
  }
}

@Riverpod(keepAlive: true)
PassageLinkService passageLinkService(Ref ref) =>
    PassageLinkService(navigation: ref.watch(bibleNavigationServiceProvider));
