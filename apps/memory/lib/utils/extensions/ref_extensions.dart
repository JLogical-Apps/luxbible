import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memory/models/user.dart';
import 'package:memory/providers/user_provider.dart';

extension WidgetRefExtension on WidgetRef {
  Future<void> updateUser(User Function(User) updater) => read(userProvider.notifier).update(updater);
}

extension ProviderContainerExtension on ProviderContainer {
  Future<void> updateUser(User Function(User) updater) => read(userProvider.notifier).update(updater);
}
