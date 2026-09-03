import 'package:bible/ui/widgets/bible_body.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/utils/bible_hook_utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:style/style.dart';
import 'package:lux/lux.dart';

class BiblePage extends HookConsumerWidget implements StyledRoute<void> {
  const BiblePage({super.key});

  @override
  String get path => '/bible';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useMessage(ref.watch(userProvider), .anonymousAnalytics);
    return StyledPage(backgroundColor: .backgroundPrimary, body: BibleBody());
  }
}
