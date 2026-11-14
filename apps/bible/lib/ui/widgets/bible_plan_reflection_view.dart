import 'package:bible/ui/pages/more_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class BiblePlanReflectionView extends StatelessWidget {
  final String question;
  final String answer;
  final bool hasDiscussion;
  final Function(String) onAnswerChanged;

  const BiblePlanReflectionView({
    super.key,
    required this.question,
    required this.answer,
    required this.hasDiscussion,
    required this.onAnswerChanged,
  });

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    bottom: false,
    child: SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: .only(left: 24, top: 24, right: 24, bottom: MediaQuery.viewPaddingOf(context).bottom + 96),
      child: Column(
        crossAxisAlignment: .stretch,
        spacing: 16,
        children: [
          Text(question, style: context.textStyle.headingXs),
          StyledTextField.multiline(
            text: answer,
            hintText: t.biblePlans.reflectionAnswerHint,
            helper: t.biblePlans.reflectionAnswerPrivacy.toText(),
            onChanged: onAnswerChanged,
          ),
          if (hasDiscussion) ...[
            gapH8,
            StyledTile.message(
              leading: FaIcon(FontAwesomeIcons.discord),
              title: t.biblePlans.discussReflection.toText(),
              action: StyledTextAction(label: t.common.join.toText(), onPressed: launchDiscord),
            ),
          ],
        ],
      ),
    ),
  );
}
