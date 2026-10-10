import 'dart:convert';
import 'dart:io';

import 'package:lux_content_tools/lux_plan_source.dart';
import 'package:lux_content_tools/repository_paths.dart';

void main() {
  final articleIdsByPrefix = LuxPlanSource.loadArticleIdsByPrefix();
  final files = sourceDirectory('lux_plans').listSync().whereType<File>().where((file) => file.path.endsWith('.md'));

  for (final file in files) {
    final id = file.uri.pathSegments.last.replaceFirst(RegExp(r'\.md$'), '');
    final plan = LuxPlanSource.parse(file.readAsStringSync());

    final errors = plan.getErrors(articleIdsByPrefix: articleIdsByPrefix);
    if (errors.isNotEmpty) throw StateError('$id has invalid content:\n${errors.join('\n')}');

    appAssetFile('bible_plans/$id.json', app: .bible).writeAsStringSync(jsonEncode(plan.toPlanJson()));
    final notesFile = appAssetFile('bible_plan_study_notes/$id.json', app: .bible)..parent.createSync(recursive: true);
    notesFile.writeAsStringSync(jsonEncode(plan.toStudyNotesJson()));
    print('$id: ${plan.days.length} days');
  }
}
