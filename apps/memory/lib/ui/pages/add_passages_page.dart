import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:memory/ui/sheets/find_in_bible_sheet.dart';
import 'package:style/style.dart';

class AddPassagesPage extends HookConsumerWidget {
  const AddPassagesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bible = ref.watch(localBibleProvider(translation: .bsb)).value;

    final passagesState = useState(<VerseSelection>[]);

    return StyledPage(
      title: 'Add Passages'.toText(),
      backgroundColor: .backgroundPrimary,
      leading: StyledCircleButton.md(child: Symbols.close.toIcon(), onPressed: () => context.pop()),
      body: StyledDock(
        shrinkWrap: false,
        children: [
          if (passagesState.value.isNotEmpty)
            StyledSection.child(
              title: 'New Passages'.toText(),
              child: StyledCard(
                children: passagesState.value
                    .map(
                      (passage) => StyledSwipeable(
                        key: ValueKey(passage),
                        actions: [
                          .delete(onPressed: () => passagesState.value = passagesState.value.withRemoved(passage)),
                        ],
                        child: StyledListItem(
                          title: passage.format().toText(),
                          subtitle: StyledLoading(
                            child: VerseText(verses: bible?.getPassageVerses(passage) ?? [], maxLines: 2),
                          ),
                          onPressed: () => PassagePreviewPage.show(context, verseSelection: passage),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          StyledSection.child(
            title: 'Add New'.toText(),
            child: StyledCard(
              children: [
                StyledListItem.navigation(
                  title: 'Pack'.toText(),
                  subtitle: 'Add a topical group of passages.'.toText(),
                  leading: Symbols.deployed_code.toIcon(),
                  onPressed: () async {
                    final pack = await context.showStyledSheet<Pack>(
                      (context, _) => StyledSheet(
                        title: 'Add Pack'.toText(),
                        children: Pack.values.map((pack) {
                          final isAlreadySelected = passagesState.value.containsAll(pack.passages);
                          return StyledListItem(
                            title: pack.title().toText(),
                            subtitle: pack.description().toText(),
                            leading: pack.icon.toIcon(),
                            thirdLine: StyledFog(
                              child: SingleChildScrollView(
                                scrollDirection: .horizontal,
                                padding: .only(top: 4),
                                child: Row(
                                  spacing: 4,
                                  children: pack.passages
                                      .map(
                                        (passage) => StyledTag.sm(
                                          child: passage.format().toText(),
                                          isEnabled: !isAlreadySelected,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                            isEnabled: !isAlreadySelected,
                            onPressed: () => context.pop(pack),
                          );
                        }).toList(),
                      ),
                    );
                    if (pack != null) {
                      passagesState.value = [...passagesState.value, ...pack.passages].distinct.toList();
                    }
                  },
                ),
                StyledListItem.navigation(
                  title: 'Find in Bible'.toText(),
                  subtitle: 'Select a specific passage from the Bible.'.toText(),
                  leading: Symbols.book.toIcon(),
                  onPressed: () async {
                    final passage = await FindInBibleSheet.show(context);
                    if (passage != null) {
                      passagesState.value = [...passagesState.value, passage].distinct.toList();
                    }
                  },
                ),
              ],
            ),
          ),
          gapH16,
        ],
        buttonsBuilder: (context) => [
          StyledRectButton.primary(
            label: 'Add ${passagesState.value.length} Passage${passagesState.value.length == 1 ? '' : 's'}'.toText(),
            onPressed: passagesState.value.isEmpty ? null : () => context.pop(passagesState.value),
          ),
        ],
      ),
    );
  }
}

enum PassageSelectionType {
  pack,
  bible;

  String title() => switch (this) {
    pack => 'Pack',
    bible => 'Find in Bible',
  };

  String description() => switch (this) {
    pack => 'Choose a pre-populated collection, such as Most Memorized Verses, Anxiety, or Depression.',
    bible => 'Search the Bible for passages you want to memorize.',
  };

  Widget buildIcon() => switch (this) {
    pack => Symbols.package_2.toIcon(),
    bible => Symbols.search.toIcon(),
  };
}

enum Pack {
  scriptureMemory,
  anxiety,
  anger,
  depression,
  grief,
  loneliness,
  stress,
  peace,
  prayer,
  faith,
  guidance,
  identity,
  forgiveness,
  joy,
  selfControl,
  temptation,
  spiritualWarfare,
  suffering,
  discipleship,
  evangelism;

  String title() => switch (this) {
    scriptureMemory => 'Scripture Memory',
    anxiety => 'Anxiety',
    anger => 'Anger',
    depression => 'Depression',
    grief => 'Grief',
    loneliness => 'Loneliness',
    stress => 'Stress',
    peace => 'Peace',
    prayer => 'Prayer',
    faith => 'Faith',
    guidance => 'Guidance',
    identity => 'Identity',
    forgiveness => 'Forgiveness',
    joy => 'Joy',
    selfControl => 'Self-Control',
    temptation => 'Temptation',
    spiritualWarfare => 'Spiritual Warfare',
    suffering => 'Suffering',
    discipleship => 'Discipleship',
    evangelism => 'Evangelism',
  };

  String description() => switch (this) {
    scriptureMemory => 'Remembering and meditating on Scripture.',
    anxiety => 'Bringing anxiety to God.',
    anger => 'Responding to anger wisely.',
    depression => 'Times of discouragement and despair.',
    grief => 'Comfort in grief.',
    loneliness => 'God’s presence and care.',
    stress => 'Finding rest amid pressure.',
    peace => 'Peace with God and others.',
    prayer => 'A life of prayer.',
    faith => 'Trusting God.',
    guidance => 'Seeking God’s direction.',
    identity => 'Who we are in Christ.',
    forgiveness => 'Receiving and extending forgiveness.',
    joy => 'Joy in the Lord.',
    selfControl => 'Self-control and godly character.',
    temptation => 'Resisting temptation.',
    spiritualWarfare => 'Standing firm in spiritual conflict.',
    suffering => 'Hope in suffering.',
    discipleship => 'Following Jesus.',
    evangelism => 'Sharing the gospel.',
  };

  IconData get icon => switch (this) {
    scriptureMemory => Symbols.menu_book,
    anxiety => Symbols.favorite,
    anger => Symbols.local_fire_department,
    depression => Symbols.cloud,
    grief => Symbols.volunteer_activism,
    loneliness => Symbols.person,
    stress => Symbols.spa,
    peace => Symbols.water_drop,
    prayer => Symbols.folded_hands,
    faith => Symbols.church,
    guidance => Symbols.explore,
    identity => Symbols.badge,
    forgiveness => Symbols.handshake,
    joy => Symbols.sentiment_satisfied,
    selfControl => Symbols.balance,
    temptation => Symbols.warning,
    spiritualWarfare => Symbols.shield,
    suffering => Symbols.healing,
    discipleship => Symbols.groups,
    evangelism => Symbols.campaign,
  };

  List<VerseSelection> get passages => switch (this) {
    scriptureMemory => [
      'John.14.26',
      'Prov.10.7',
      'Ps.119.11',
      '1Cor.2.16',
      'Heb.4.12',
      'Isa.50.4',
      'Isa.46.9',
      'Ps.49.3-Ps.49.4',
      '1John.2.27',
      'Exod.4.12',
    ],
    anxiety => [
      'Phil.4.6-Phil.4.7',
      '1Pet.5.7',
      'John.14.27',
      '2Tim.1.7',
      'Ps.55.22',
      'Phil.4.6',
      'Matt.6.25-Matt.6.34',
      '1Pet.5.6-1Pet.5.7',
      'Heb.13.6',
      'Josh.1.9',
    ],
    anger => [
      'Prov.14.29',
      'Ps.37.8',
      'Prov.15.1',
      'Jas.1.20',
      'Eph.4.26',
      'Jas.1.19',
      'Prov.29.11',
      'Eccl.7.9',
      'Prov.19.11',
      'Jas.1.19-Jas.1.20',
    ],
    depression => [
      'Ps.34.17-Ps.34.18',
      '2Cor.7.6',
      'Isa.41.10',
      '1Pet.5.7',
      'Matt.11.28',
      'Jer.29.11',
      'Prov.3.5-Prov.3.6',
      'Ps.143.7-Ps.143.8',
      'Phil.4.6-Phil.4.7',
      'Ps.30.5',
    ],
    grief => [
      'Matt.5.4',
      'Rev.21.4',
      'Ps.147.3',
      'Ps.34.18',
      '1Pet.5.7',
      'John.16.22',
      'Matt.11.28-Matt.11.30',
      'Ps.73.26',
      'Rom.8.18',
      'John.14.27',
    ],
    loneliness => [
      'Isa.41.10',
      'Ps.27.10',
      'Matt.28.20',
      'Deut.31.6',
      '1Pet.5.7',
      'Ps.23.4',
      'Gen.2.18',
      'Ps.147.3',
      'John.14.18',
      'Heb.13.5',
    ],
    stress => [
      'Phil.4.6',
      'John.14.27',
      'Ps.55.22',
      'Prov.12.25',
      'Ps.118.5-Ps.118.6',
      'Matt.11.28-Matt.11.30',
      'Rom.8.31',
      'Rom.8.28',
      'Matt.6.34',
      'Matt.6.27',
    ],
    peace => [
      'John.16.33',
      '2Thess.3.16',
      'Isa.26.3',
      'Matt.5.9',
      'John.14.27',
      'Ps.4.8',
      'Phil.4.6',
      'Col.3.15',
      'Rom.12.18',
      'Heb.12.14',
    ],
    prayer => [
      'Mark.11.24',
      'Rom.8.26',
      'Phil.4.6',
      'Jas.5.16',
      'Matt.6.6',
      'Matt.6.7',
      'Col.4.2',
      '1Thess.5.17',
      'Jer.33.3',
    ],
    faith => [
      'Heb.11.6',
      'Matt.21.22',
      'Rom.10.17',
      'Heb.11.1',
      'Mark.11.22-Mark.11.24',
      '2Cor.5.7',
      'Eph.2.8-Eph.2.9',
      'Prov.3.5-Prov.3.6',
      'Luke.1.37',
      'Jas.2.19',
    ],
    guidance => [
      'Prov.3.5-Prov.3.6',
      'Ps.32.8',
      'Ps.119.105',
      'John.16.13',
      'Isa.30.21',
      'Prov.11.14',
      'Prov.16.9',
      'Matt.7.7-Matt.7.11',
      'Ps.25.4-Ps.25.5',
      'Jas.1.5-Jas.1.6',
    ],
    identity => [
      'Gen.1.27',
      '2Cor.5.17',
      '1Pet.2.9',
      'Gal.2.20',
      'Jer.1.5',
      'Eph.2.10',
      'John.1.12',
      'Jer.29.11',
      '1Cor.12.27',
      'John.15.15',
    ],
    forgiveness => [
      'Eph.4.32',
      'Mark.11.25',
      '1John.1.9',
      'Matt.6.15',
      'Matt.18.21-Matt.18.22',
      'Matt.6.14-Matt.6.15',
      'Luke.6.37',
      'Col.3.13',
      'Jas.5.16',
      'Luke.6.27',
    ],
    joy => [
      'Rom.15.13',
      'Rom.12.12',
      'Phil.4.4',
      'Jas.1.2',
      'Ps.16.11',
      'John.16.24',
      'Gal.5.22',
      'Prov.17.22',
      'John.16.22',
      'John.15.11',
    ],
    selfControl => [
      'Prov.25.28',
      '2Tim.1.7',
      'Titus.1.8',
      'Gal.5.19-Gal.5.25',
      '1Pet.4.7',
      'Gal.5.22-Gal.5.23',
      'Prov.16.32',
      '2Pet.1.5-2Pet.1.6',
      'Titus.2.6',
      '1Cor.9.27',
    ],
    temptation => [
      '1Cor.10.13',
      'Matt.26.41',
      'Jas.4.7',
      'Jas.1.12-Jas.1.16',
      'Heb.2.18',
      'Eph.6.11',
      'Matt.4.1-Matt.4.11',
      'Mark.14.38',
      'Eph.4.27',
      'Jas.1.12',
    ],
    spiritualWarfare => [
      'Eph.6.12',
      'Eph.6.11',
      '2Cor.10.3-2Cor.10.5',
      'Jas.4.7',
      '1Pet.5.8',
      'Ps.91.1-Ps.91.16',
      'Luke.10.19',
      'Deut.28.7',
      'Eph.6.13',
      '2Cor.10.4',
    ],
    suffering => [
      '1Pet.5.10',
      'Rom.8.18',
      'Rom.5.3-Rom.5.5',
      'Jas.1.2-Jas.1.4',
      'Ps.34.19',
      'John.16.33',
      'Rev.21.4',
      'Rom.5.3-Rom.5.4',
      '2Tim.3.12',
      'Rom.8.28',
    ],
    discipleship => [
      'Matt.28.18-Matt.28.20',
      'Luke.14.27',
      'Luke.9.23',
      '2Tim.2.2',
      'John.8.31-John.8.32',
      'Luke.14.33',
      'Luke.6.40',
      'John.13.34-John.13.35',
      'Matt.5.14-Matt.5.16',
      'Luke.14.26',
    ],
    evangelism => [
      'Mark.16.15',
      'Matt.28.19-Matt.28.20',
      '1Pet.3.15',
      'Rom.1.16',
      'Acts.1.8',
      'Matt.9.37-Matt.9.38',
      'Ps.105.1',
    ],
  }.map(VerseSelection.fromOsisId).toList();
}
