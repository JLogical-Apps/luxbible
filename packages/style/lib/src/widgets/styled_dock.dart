import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';
import 'package:style/src/gap.dart';
import 'package:style/src/style_context_extensions.dart';
import 'package:style/src/styled_shadow.dart';
import 'package:style/src/widgets/styled_list_view.dart';
import 'package:style/src/widgets/styled_size_and_fade.dart';

class StyledDock extends HookWidget {
  final List<Widget> children;
  final EdgeInsets childrenPadding;

  final Widget? aboveButtons;
  final List<Widget> Function(BuildContext)? buttonsBuilder;

  final bool shrinkWrap;
  final bool forceHeight;

  final Object? activeScrollKey;
  final bool? forceBottomShadow;

  final ScrollController? controller;

  const StyledDock({
    super.key,
    required this.children,
    this.childrenPadding = .zero,
    this.aboveButtons,
    this.buttonsBuilder,
    this.shrinkWrap = true,
    this.forceHeight = false,
    this.activeScrollKey,
    this.forceBottomShadow,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final buttons = buttonsBuilder?.call(context) ?? [];
    final aboveButtons = this.aboveButtons;

    final bottomChildren = buttons.isEmpty && aboveButtons == null
        ? <Widget>[]
        : [
            StyledSizeAndFade(child: aboveButtons ?? SizedBox(width: double.infinity, height: 16)),
            if (buttons.isNotEmpty)
              Padding(
                padding: .symmetric(horizontal: 16),
                child: Column(spacing: 8, mainAxisSize: .min, children: buttons),
              ),
            Builder(
              builder: (context) => kIsWeb || !Platform.isIOS || MediaQuery.paddingOf(context).bottom <= 28
                  ? buttons.isNotEmpty
                        ? gapH16
                        : gapH8
                  : SizedBox.shrink(),
            ),
          ];

    final metricsState = useState<ScrollMetrics?>(null);
    final metricsByKeyState = useState(<Object, ScrollMetrics>{});

    final metrics = activeScrollKey == null ? metricsState.value : metricsByKeyState.value[activeScrollKey];

    final showBottomShadow =
        forceBottomShadow ??
        (aboveButtons != null ||
            (bottomChildren.isNotEmpty && (metrics == null ? false : metrics.pixels + 10 < metrics.maxScrollExtent)));

    return LayoutBuilder(
      builder: (context, constraints) => NotificationListener<KeyedScrollNotification>(
        onNotification: (e) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) metricsByKeyState.value = {...metricsByKeyState.value, e.key: e.metrics};
          });
          return false;
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (e) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) metricsState.value = e.metrics;
            });
            return false;
          },
          child: NotificationListener<ScrollMetricsNotification>(
            onNotification: (e) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) metricsState.value = e.metrics;
              });
              return false;
            },
            child: ScrollAbsorber(
              allowPropagate: (e, metrics) => e.depth == 0 && metrics.axis == .vertical,
              child: Column(
                mainAxisSize: .min,
                children: [
                  Builder(
                    builder: (context) => MediaQuery.removePadding(
                      context: context,
                      removeBottom: buttons.isNotEmpty,
                      child: Flexible(
                        fit: shrinkWrap ? .loose : .tight,
                        child: Stack(
                          children: [
                            forceHeight
                                ? LayoutBuilder(
                                    builder: (context, constraints) => SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      controller: controller,
                                      padding: childrenPadding,
                                      child: ClipRect(
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(maxHeight: constraints.maxHeight),
                                          child: Column(
                                            crossAxisAlignment: .start,
                                            mainAxisSize: .min,
                                            children: children,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : StyledListView(
                                    shrinkWrap: shrinkWrap,
                                    controller: controller,
                                    physics: shrinkWrap ? ClampingScrollPhysics() : null,
                                    padding:
                                        childrenPadding +
                                        .only(
                                          bottom: bottomChildren.isEmpty ? MediaQuery.paddingOf(context).bottom : 0,
                                        ),
                                    children: children,
                                  ),
                            Positioned(
                              bottom: -16,
                              left: 0,
                              right: 0,
                              height: 16,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 100),
                                curve: Curves.easeInOutCubic,
                                width: double.infinity,
                                decoration: BoxDecoration(boxShadow: [if (showBottomShadow) StyledShadow.up(context)]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  StyledSizeAndFade.showHide(
                    show: bottomChildren.isNotEmpty,
                    child: ColoredBox(
                      color: context.colors.surfacePrimary,
                      child: ClipRect(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: constraints.maxHeight),
                          child: Builder(
                            builder: (context) => Padding(
                              padding: .only(bottom: MediaQuery.paddingOf(context).bottom),
                              child: Column(mainAxisSize: .min, children: bottomChildren),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Builder(builder: (context) => SizedBox(height: MediaQuery.viewInsetsOf(context).bottom)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
