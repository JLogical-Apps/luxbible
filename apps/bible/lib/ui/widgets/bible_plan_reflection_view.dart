import 'package:bible/ui/pages/more_page.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class BiblePlanReflectionView extends StatelessWidget {
  final List<String> questions;
  final Map<int, String> answerByQuestionIndex;
  final bool hasDiscussion;
  final Function(int questionIndex, String answer) onAnswerChanged;

  const BiblePlanReflectionView({
    super.key,
    required this.questions,
    required this.answerByQuestionIndex,
    required this.hasDiscussion,
    required this.onAnswerChanged,
  });

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    bottom: false,
    // The page doesn't resize for the keyboard, so the view ends above it to keep the focused answer reachable.
    child: Padding(
      padding: .only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: .only(left: 24, top: 24, right: 24, bottom: MediaQuery.paddingOf(context).bottom + 96),
        child: Column(
          crossAxisAlignment: .stretch,
          spacing: 24,
          children: [
            ...questions.mapIndexed(
              (questionIndex, question) => Column(
                crossAxisAlignment: .stretch,
                spacing: 16,
                children: [
                  Text(question, style: context.textStyle.headingXs),
                  StyledTextField.multiline(
                    text: answerByQuestionIndex[questionIndex] ?? '',
                    hintText: t.biblePlans.reflectionAnswerHint,
                    helper: questionIndex == questions.length - 1
                        ? (questions.length == 1
                                  ? t.biblePlans.reflectionAnswerPrivacy
                                  : t.biblePlans.reflectionAnswersPrivacy)
                              .toText()
                        : null,
                    // Keeps the caret clear of the toolbar floating over the bottom of the view.
                    scrollPadding: .only(left: 20, top: 20, right: 20, bottom: 112),
                    onChanged: (answer) => onAnswerChanged(questionIndex, answer),
                  ),
                ],
              ),
            ),
            if (hasDiscussion)
              StyledTile.message(
                leading: FaIcon(FontAwesomeIcons.discord),
                title: t.biblePlans.discussReflection.toText(),
                action: StyledTextAction(label: t.common.join.toText(), onPressed: launchDiscord),
              ),
          ],
        ),
      ),
    ),
  );
}
