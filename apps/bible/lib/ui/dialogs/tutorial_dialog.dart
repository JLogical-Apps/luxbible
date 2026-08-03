import 'package:lux/i18n.dart';
import 'package:bible/models/user/tutorial.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';

class TutorialDialog extends StyledDialog {
  TutorialDialog({super.key, required super.title, required super.body, required Tutorial tutorial})
    : super(
        buttonsBuilder: (context) => [
          StyledRectButton.secondary(
            label: t.tutorials.dontShowAgain.toText(),
            onPressed: () {
              ref.updateUser((user) => user.withTutorial(tutorial));
              context.pop();
            },
          ),
          StyledRectButton.primary(label: t.common.ok.toText(), onPressed: () => context.pop()),
        ],
      );
}
