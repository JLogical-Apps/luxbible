import 'dart:io';

import 'package:bible/style/gap.dart';
import 'package:bible/style/keyed_scroll_notification.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/styled_shadow.dart';
import 'package:bible/style/widgets/scroll_absorber.dart';
import 'package:bible/style/widgets/styled_list_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StyledDock extends HookWidget {
  final List<Widget> children;

  final Widget? aboveButtons;
  final List<Widget> Function(BuildContext)? buttonsBuilder;

  final bool shrinkWrap;
  final bool forceHeight;

  final Object? activeScrollKey;

  final ScrollController? controller;

  const StyledDock({
    super.key,
    required this.children,
    this.aboveButtons,
    this.buttonsBuilder,
    this.shrinkWrap = true,
    this.forceHeight = false,
    this.activeScrollKey,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final buttons = buttonsBuilder?.call(context) ?? [];

    final bottomChildren = buttons.isEmpty && aboveButtons == null
        ? <Widget>[]
        : [
            if (aboveButtons case final aboveButtons?) aboveButtons else gapH16,
            if (buttons.isNotEmpty)
              Padding(
                padding: .symmetric(horizontal: 16),
                child: Column(spacing: 8, mainAxisSize: .min, children: buttons),
              ),
            if (kIsWeb || !Platform.isIOS || MediaQuery.paddingOf(context).bottom <= 28)
              buttons.isNotEmpty ? gapH16 : gapH8,
          ];

    final metricsState = useState<ScrollMetrics?>(null);
    final metricsByKeyState = useState(<Object, ScrollMetrics>{});

    final metrics = activeScrollKey == null ? metricsState.value : metricsByKeyState.value[activeScrollKey];

    final showBottomShadow =
        aboveButtons != null || (metrics == null ? false : metrics.pixels + 10 < metrics.maxScrollExtent);

    return Padding(
      padding: .only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: MediaQuery.removeViewInsets(
        removeBottom: true,
        context: context,
        child: LayoutBuilder(
          builder: (context, constraints) => NotificationListener<KeyedScrollNotification>(
            onNotification: (e) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  metricsByKeyState.value = {...metricsByKeyState.value, e.key: e.metrics};
                }
              });
              return false;
            },
            child: NotificationListener<ScrollNotification>(
              onNotification: (e) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted) {
                    metricsState.value = e.metrics;
                  }
                });
                return false;
              },
              child: NotificationListener<ScrollMetricsNotification>(
                onNotification: (e) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (context.mounted) {
                      metricsState.value = e.metrics;
                    }
                  });
                  return false;
                },
                child: ScrollAbsorber(
                  allowPropagate: (e, metrics) => e.depth == 0 && metrics.axis == .vertical,
                  child: Column(
                    mainAxisSize: .min,
                    children: [
                      MediaQuery.removePadding(
                        context: context,
                        removeBottom: buttons.isNotEmpty,
                        child: Flexible(
                          fit: shrinkWrap ? .loose : .tight,
                          child: Stack(
                            children: [
                              forceHeight
                                  ? LayoutBuilder(
                                      builder: (context, constraints) => SingleChildScrollView(
                                        controller: controller,
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
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      controller: controller,
                                      padding: .only(
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
                                  decoration: BoxDecoration(
                                    boxShadow: [if (showBottomShadow) StyledShadow.up(context)],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (bottomChildren.isNotEmpty)
                        ColoredBox(
                          color: context.colors.surfacePrimary,
                          child: ClipRect(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: constraints.maxHeight),
                              child: Padding(
                                padding: .only(bottom: MediaQuery.paddingOf(context).bottom),
                                child: Column(mainAxisSize: .min, children: bottomChildren),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
