import 'package:bible/models/study_panel.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class PinStudyPanelButton extends StatelessWidget {
  final StudyPanel studyPanel;
  final Function(StudyPanel) onAddStudyPanel;

  const PinStudyPanelButton({super.key, required this.studyPanel, required this.onAddStudyPanel});

  @override
  Widget build(BuildContext context) => Tooltip(
    message: t.studyPanels.pinAsStudyPanel,
    child: StyledCircleButton.md(
      child: Symbols.push_pin.toIcon(),
      onPressed: () {
        context.pop();
        onAddStudyPanel(studyPanel);
      },
    ),
  );
}
