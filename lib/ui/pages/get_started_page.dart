import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/onboarding_page.dart';
import 'package:bible/ui/widgets/bible_body.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StyledPage(
      body: StyledDock(
        shrinkWrap: false,
        children: [
          SizedBox(height: MediaQuery.paddingOf(context).top),
          gapH16,
          Text('Scripture Deserves Better Software', style: context.textStyle.displayXs, textAlign: .center),
          gapH16,
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Padding(
              padding: .all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: context.colors.backgroundPrimary,
                  borderRadius: .circular(24),
                  border: .all(color: context.colors.borderSelected, width: 4),
                ),
                height: MediaQuery.sizeOf(context).height - 256,
                child: IgnorePointer(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      const scale = 0.8;
                      return Transform.scale(
                        scale: scale,
                        child: OverflowBox(
                          minWidth: constraints.maxWidth / scale,
                          maxWidth: constraints.maxWidth / scale,
                          minHeight: constraints.maxHeight / scale,
                          maxHeight: constraints.maxHeight / scale,
                          child: BibleBody(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
        buttonsBuilder: (context) => [
          StyledRectButton.primary(label: 'Get Started'.toText(), onPressed: () => context.push(OnboardingPage())),
        ],
      ),
    );
  }
}
