import 'dart:io';

import 'package:bible/models/whats_new_highlight.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/pages/more_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class WhatsNewSheet {
  static Future<void> show(BuildContext context) {
    ref.read(userProvider.notifier).markWhatsNewOpened();
    return context.showStyledSheet(
      (context, _) => StyledSheet(
        title: t.whatsNew.title.toText(),
        subtitle: 'Lux ${WhatsNewHighlight.releaseVersion}'.toText(),
        children: [
          StyledList(
            children: WhatsNewHighlight.values
                .map(
                  (highlight) => StyledListItem(
                    title: highlight.title().toText(),
                    subtitle: highlight.description().toText(),
                    leading: highlight.icon.toIcon(),
                  ),
                )
                .toList(),
          ),
          Padding(
            padding: .all(16),
            child: Column(
              spacing: 8,
              children: [
                StyledTile.message(
                  leading: Symbols.star.toIcon(),
                  title: t.whatsNew.enjoyingLux.toText(),
                  subtitle: t.whatsNew.reviewInvitation(store: Platform.isIOS ? 'App Store' : 'Play Store').toText(),
                  action: StyledTextAction(label: t.whatsNew.rate.toText(), onPressed: launchStoreReview),
                ),
                StyledTile.message(
                  leading: FaIcon(FontAwesomeIcons.discord),
                  title: t.whatsNew.haveIdeas.toText(),
                  subtitle: t.whatsNew.discordInvitation.toText(),
                  action: StyledTextAction(label: t.common.join.toText(), onPressed: launchDiscord),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
