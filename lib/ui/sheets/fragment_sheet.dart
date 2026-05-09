import 'package:bible/models/bible/study/verse_fragment.dart';
import 'package:bible/models/morphology.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/style/widgets/dialog/styled_dialog.dart';
import 'package:bible/ui/sheets/strong_sheet.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:utils_core/utils_core.dart';

class FragmentSheet {
  static Future<void> showWithContext(
    BuildContext context,
    WidgetRef ref, {
    required VerseFragment fragment,
    required User user,
    required Function(Passage) onNavigateToPassage,
  }) async {
    final study = fragment.study;
    final inflection = study?.inflection;
    if (study == null || inflection == null) {
      return;
    }

    final strongs = ref.read(strongsProvider);
    final strong = strongs[study.strongId];

    await context.showStyledSheetWithBreadcrumbs(breadcrumbText: inflection, (context) {
      final morphologyCode = study.morphology;
      final morphologyCodes = morphologyCode == null ? null : Morphology.splitCode(morphologyCode);
      final selectedMorphologyCodeState = useState(morphologyCodes?.firstOrNull);
      final selectedMorphologyCode = selectedMorphologyCodeState.value;

      return StyledSheet(
        title: 'Interlinear Word'.toText(),
        subtitle: inflection.toText(),
        children: [
          StyledSection(
            title: 'Info'.toText(),
            padding: .only(top: 24),
            children: [
              StyledListItem(title: 'Inflected'.toText(), subtitle: inflection.toText()),
              StyledListItem(title: 'English'.toText(), subtitle: fragment.text.toText()),
            ],
          ),
          if (strong != null)
            StyledSection(
              title: 'Root Word'.toText(),
              padding: .only(top: 24),
              children: [
                StyledListItem.navigation(
                  title: 'Strongs Number'.toText(),
                  subtitle: strong.id.toText(),
                  onPressed: () {
                    context.pop();
                    StrongSheet.showWithContext(
                      context,
                      ref,
                      strongId: strong.id,
                      user: user,
                      onNavigateToPassage: onNavigateToPassage,
                    );
                  },
                ),
                StyledListItem(title: 'Root Word'.toText(), subtitle: strong.languageText.toText()),
                StyledListItem(title: 'Transliteration'.toText(), subtitle: strong.transliteration.toText()),
              ],
            ),
          if (morphologyCode != null && morphologyCodes != null && selectedMorphologyCode != null)
            StyledSection(
              title: 'Morphology'.toText(),
              subtitle: morphologyCode.toText(),
              trailing: morphologyCodes.length == 1
                  ? null
                  : StyledSegmentedControl(
                      options: morphologyCodes,
                      onOptionSelected: (code) => selectedMorphologyCodeState.value = code,
                      selectedOption: selectedMorphologyCode,
                      textBuilder: (morphology) => morphology,
                    ),
              padding: .only(top: 24),
              children: Morphology.parse(selectedMorphologyCode).attributes
                  .mapToIterable(
                    (attribute, value) => StyledListItem(
                      title: attribute.displayName.toText(),
                      subtitle: value.displayName.toText(),
                      trailing: StyledPillButton(
                        label: 'Learn More'.toText(),
                        onPressed: () => context.showStyledDialog(
                          (context) => StyledDialog.confirm(
                            title: 'Morphology Info'.toText(),
                            bodyPadding: .zero,
                            body: StyledList(
                              children: [
                                StyledListItem(
                                  title: attribute.displayName.toText(),
                                  subtitle: attribute.description.toText(),
                                ),
                                StyledListItem(
                                  title: value.displayName.toText(),
                                  subtitle: value.description.toText(),
                                  thirdLine: value.examples.isEmpty
                                      ? null
                                      : [
                                          'Examples: ',
                                          value.examples.map((example) => '"$example"').join(', '),
                                        ].join().toText(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      );
    });
  }
}
