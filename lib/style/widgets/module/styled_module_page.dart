import 'dart:async';

import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StyledModulePage extends HookWidget {
  final Widget title;
  final List<StyledModuleStep> steps;

  const StyledModulePage({super.key, required this.title, required this.steps});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final stepIndexState = useState(0);
    final currentStep = steps[stepIndexState.value];

    void goNext() {
      final nextStepIndex = stepIndexState.value + 1;
      FocusManager.instance.primaryFocus?.unfocus();
      pageController.animateToPage(nextStepIndex, duration: Duration(milliseconds: 300), curve: Curves.easeInOutCubic);
    }

    void goBack() {
      FocusManager.instance.primaryFocus?.unfocus();

      pageController.animateToPage(
        stepIndexState.value - 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
      );
    }

    Future<void> handlePopAttempt() async {
      if (stepIndexState.value > 0) {
        goBack();
        return;
      }

      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, _) async {
        if (didPop) {
          return;
        }

        handlePopAttempt();
      },
      child: StyledPage(
        title: title,
        onBackPressed: (context) => context.maybePop(),
        body: Column(
          children: [
            Padding(
              padding: .symmetric(horizontal: 16),
              child: StyledProgressBar(value: (stepIndexState.value + 1) / steps.length),
            ),
            Expanded(
              child: StyledPageDock(
                controller: pageController,
                onPageChanged: (page) => stepIndexState.value = page,
                pages: steps
                    .mapIndexed(
                      (pageIndex, page) => StyledPageDockPage(
                        padding: .zero,
                        forceFillHeight: page.forceFillHeight,
                        children: [
                          gapH24,
                          Padding(
                            padding: .symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: .start,
                              spacing: 4,
                              children: [
                                DefaultTextStyle(child: page.title, style: context.textStyle.headingSm),
                                if (page.subtitle case final subtitle?)
                                  DefaultTextStyle(child: subtitle, style: context.textStyle.paragraphMd),
                              ],
                            ),
                          ),
                          gapH24,
                          page.forceFillHeight
                              ? Expanded(
                                  child: Padding(
                                    padding: page.bodyPadding,
                                    child: Column(children: page.childrenBuilder(context)),
                                  ),
                                )
                              : Padding(
                                  padding: page.bodyPadding,
                                  child: Column(children: page.childrenBuilder(context)),
                                ),
                        ],
                      ),
                    )
                    .toList(),
                buttonsBuilder: (context) => currentStep.buttons.buildButtons(context, goNext),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StyledModuleStep {
  final Widget title;
  final Widget? subtitle;

  final List<Widget> Function(BuildContext) childrenBuilder;
  final EdgeInsets bodyPadding;

  final StyledModuleButtons buttons;

  final bool forceFillHeight;

  const StyledModuleStep({
    required this.title,
    this.subtitle,
    required this.childrenBuilder,
    this.bodyPadding = const .symmetric(horizontal: 16),
    this.buttons = const _NextStyledModuleButtons(),
    this.forceFillHeight = false,
  });

  static StyledModuleStep selection<T>({
    required Widget title,
    Widget? subtitle,
    required List<T> options,
    required T? selectedOption,
    required StyledSelectOption<T> Function(T) optionMapper,
    required Function(T) onSelectOption,
    bool canGoNext = true,
  }) => StyledModuleStep(
    title: title,
    subtitle: subtitle,
    bodyPadding: .symmetric(horizontal: 16),
    childrenBuilder: (context) => [
      Column(
        spacing: 12,
        children: options
            .map(
              (option) => StyledTile(
                isSelected: option == selectedOption,
                child: StyledListItem.radio(
                  title: optionMapper(option).title,
                  subtitle: optionMapper(option).subtitle,
                  leading: optionMapper(option).leading,
                  isSelected: selectedOption == option,
                  onSelected: () => onSelectOption(option),
                ),
              ),
            )
            .toList(),
      ),
    ],
    buttons: .next(canGoNext: canGoNext),
  );
}

sealed class StyledModuleButtons {
  List<Widget> buildButtons(BuildContext context, Function() goNext);

  static StyledModuleButtons next({bool canGoNext = true, FutureOr Function()? onGoNext, Widget? label}) =>
      _NextStyledModuleButtons(canGoNext: canGoNext, onGoNext: onGoNext, label: label);

  static StyledModuleButtons custom({required List<Widget> Function(BuildContext, Function() goNext) buttonsBuilder}) =>
      _CustomStyledModuleButtons(buttonsBuilder: buttonsBuilder);
}

class _NextStyledModuleButtons implements StyledModuleButtons {
  final bool canGoNext;
  final FutureOr Function()? onGoNext;
  final Widget? label;

  const _NextStyledModuleButtons({this.canGoNext = true, this.onGoNext, this.label});

  @override
  List<Widget> buildButtons(BuildContext context, Function() goNext) => [
    StyledRectButton.primary(
      label: label ?? 'Next'.toText(),
      onPressed: canGoNext
          ? () async {
              await onGoNext?.call();
              goNext();
            }
          : null,
    ),
  ];
}

class _CustomStyledModuleButtons implements StyledModuleButtons {
  final List<Widget> Function(BuildContext, Function() goNext) buttonsBuilder;

  const _CustomStyledModuleButtons({required this.buttonsBuilder});

  @override
  List<Widget> buildButtons(BuildContext context, Function() goNext) => buttonsBuilder(context, goNext);
}
