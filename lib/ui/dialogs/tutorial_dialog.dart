import 'package:bible/models/user/tutorial.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';

class TutorialDialog extends StyledDialog {
  TutorialDialog({super.key, required super.title, required super.body, required Tutorial tutorial})
    : super(
        buttonsBuilder: (context) => [
          StyledRectButton.secondary(
            label: "Don't Show Again".toText(),
            onPressed: () {
              ref.updateUser((user) => user.withTutorial(tutorial));
              context.pop();
            },
          ),
          StyledRectButton.primary(label: 'Ok'.toText(), onPressed: () => context.pop()),
        ],
      );
}
