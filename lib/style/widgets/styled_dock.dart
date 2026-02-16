import 'dart:io';

import 'package:bible/style/gap.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/styled_shadow.dart';
import 'package:bible/style/widgets/scroll_absorber.dart';
import 'package:bible/style/widgets/styled_list_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StyledDock extends HookWidget {
  final List<Widget> children;
  final List<Widget> Function(BuildContext)? buttonsBuilder;

  const StyledDock({super.key, required this.children, this.buttonsBuilder});

  @override
  Widget build(BuildContext context) {
    final buttons = buttonsBuilder?.call(context) ?? [];

    final bottomChildren = buttons.isEmpty
        ? <Widget>[]
        : [
            gapH16,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(spacing: 8, mainAxisSize: MainAxisSize.min, children: buttons),
            ),
            if (kIsWeb || !Platform.isIOS || MediaQuery.paddingOf(context).bottom <= 28)
              buttons.isNotEmpty ? gapH16 : gapH8,
          ];

    final metricsState = useState<ScrollMetrics?>(null);
    final metrics = metricsState.value;

    final showBottomShadow = metrics == null ? false : metrics.pixels + 10 < metrics.maxScrollExtent;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: MediaQuery.removeViewInsets(
        removeBottom: true,
        context: context,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return NotificationListener<ScrollNotification>(
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
                  allowPropagate: (e, metrics) => e.depth == 0 && metrics.axis == Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MediaQuery.removePadding(
                        context: context,
                        removeBottom: buttons.isNotEmpty,
                        child: Flexible(
                          fit: FlexFit.loose,
                          child: Stack(
                            children: [
                              StyledListView(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                padding: EdgeInsets.only(
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
                                padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
                                child: Column(mainAxisSize: MainAxisSize.min, children: bottomChildren),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
