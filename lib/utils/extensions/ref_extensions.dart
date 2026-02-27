import 'package:bible/models/user/user.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension WidgetRefExtension on WidgetRef {
  Future<void> updateUser(User Function(User) updater) => read(userProvider.notifier).update(updater);
}
