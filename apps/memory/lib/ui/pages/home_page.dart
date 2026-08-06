import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:memory/models/activity_plan.dart';
import 'package:memory/providers/user_provider.dart';
import 'package:memory/ui/pages/chapter_preview_page.dart';
import 'package:memory/utils/extensions/ref_extensions.dart';
import 'package:style/style.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return StyledPage(
      body: StyledListView(
        padding: MediaQuery.paddingOf(context).onlyVertical,
        children: [
          Padding(
            padding: .all(64),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 256),
              child: AspectRatio(
                aspectRatio: 1,
                child: AvatarGlow(
                  glowColor: context.colors.contentPrimary,
                  glowRadiusFactor: 0.1,
                  child: StyledMaterial(
                    borderRadius: .circular(999),
                    colorBuilder: .primary,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          'Practice',
                          style: context.textStyle.displaySm.copyWith(color: context.colors.contentPrimaryInverse),
                        ),
                        Text(
                          '3-5 Minutes',
                          style: context.textStyle.labelMd.copyWith(color: context.colors.inverted.contentSecondary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          StyledSection(
            title: 'Library'.toText(),
            trailing: StyledCircleButton.md(
              child: Symbols.add.toIcon(),
              colorBuilder: .surfaceSecondary,
              onPressed: () => ref.updateUser(
                (user) =>
                    user.copyWith(passages: [...user.passages, VerseSelection.reference(Reference.values.random)]),
              ),
            ),
            children: [
              if (user.passages.isEmpty)
                Padding(
                  padding: .symmetric(horizontal: 16),
                  child: StyledTile.message(
                    leading: Symbols.text_ad.toIcon(),
                    title: 'No Passages'.toText(),
                    subtitle: 'Add a passage by tapping the + button above'.toText(),
                  ),
                ),
              ...user.passages.mapIndexed(
                (passageIndex, passage) => StyledListItem(
                  title: passage.format().toText(),
                  subtitle: Padding(
                    padding: .only(top: 8),
                    child: StyledProgressBar(value: Random().nextDouble()),
                  ),
                  trailing: StyledCircleButton.md(
                    child: Symbols.more_vert.toIcon(),
                    onPressed: () => context.showStyledSheet(
                      (context) => StyledSheet(
                        title: passage.format().toText(),
                        children: [
                          StyledListItem(
                            title: 'Practice'.toText(),
                            subtitle: 'Play an activity to practice this passage.'.toText(),
                            leading: Symbols.exercise.toIcon(),
                            onPressed: () async {
                              context.pop();
                              await context.showStyledSheet(
                                (context) => StyledSelectionSheet(
                                  title: 'Practice Activity'.toText(),
                                  options: ActivityPlanType.values.where((type) => type.isPracticeActivity).toList(),
                                  optionMapper: (type) => StyledSelectOption(
                                    title: type.title().toText(),
                                    subtitle: type.description().toText(),
                                    leading: type.icon.toIcon(),
                                  ),
                                ),
                              );
                            },
                          ),
                          StyledListItem(
                            title: 'Read'.toText(),
                            subtitle: 'Read this passage'.toText(),
                            leading: Symbols.book.toIcon(),
                            onPressed: () {
                              context.pop();
                              context.push(
                                ChapterPreviewPage(
                                  chapterReference: passage.references.first.toChapterReference(),
                                  translation: .bsb,
                                  selection: passage,
                                ),
                              );
                            },
                          ),
                          StyledListItem(
                            title: 'Study'.toText(),
                            subtitle: 'Study this passage with Lux'.toText(),
                            leading: ClipRRect(
                              borderRadius: .circular(8),
                              child: ColorFiltered(
                                colorFilter: .saturation(0),
                                child: Image.asset('assets/images/lux-logo-full.png', width: 32, height: 32),
                              ),
                            ),
                            onPressed: () {
                              context.pop();
                              context.push(
                                ChapterPreviewPage(
                                  chapterReference: ChapterReference(book: .genesis, chapterNum: 1),
                                  translation: .bsb,
                                  selection: passage,
                                ),
                              );
                            },
                          ),
                          StyledListItem(
                            title: 'Remove'.toText(),
                            subtitle: 'Removes this passage from your Library'.toText(),
                            leading: Icon(Symbols.delete, color: context.colors.contentCritical),
                            onPressed: () {
                              context.pop();
                              ref.updateUser(
                                (user) => user.copyWith(passages: user.passages.withRemovedAt(passageIndex)),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
