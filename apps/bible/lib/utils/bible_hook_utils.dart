import 'package:bible/models/user/message.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

void useMessage(User user, Message message) {
  final context = useContext();
  usePostFrameEffect(() {
    if (user.messages.contains(message)) {
      ref.updateUser((user) => user.withMessagePopped(message));
      context.showStyledDialog(
        (context) => StyledDialog.confirm(title: message.title().toText(), body: message.description().toText()),
      );
    }
  }, [user, message]);
}
