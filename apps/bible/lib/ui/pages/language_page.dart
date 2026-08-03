import 'package:lux/i18n.dart';
import 'package:bible/models/user/language.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:style/style.dart';
import 'package:lux/lux.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LanguagePage extends ConsumerWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return StyledPage(
      title: t.settings.language.toText(),
      backgroundColor: .backgroundPrimary,
      body: ListView(
        children: [
          StyledSection.child(
            title: t.settings.language.toText(),
            child: StyledCard(
              children: [
                StyledListItem.radio(
                  title: t.settings.system.toText(),
                  subtitle: t.settings.systemLanguageDescription.toText(),
                  isSelected: user.languageOverride == null,
                  onSelected: () {
                    LocaleSettings.setLocaleSync(Language.device.appLocale);
                    ref.updateUser((user) => user.withLanguage(null));
                  },
                ),
                ...Language.values.map(
                  (language) => StyledListItem.radio(
                    title: language.nativeTitle.toText(),
                    isSelected: user.languageOverride == language,
                    onSelected: () {
                      LocaleSettings.setLocaleSync(language.appLocale);
                      ref.updateUser((user) => user.withLanguage(language));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
