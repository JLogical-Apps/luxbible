import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class StyledPageDock extends HookWidget {
  final List<StyledPageDockPage> pages;
  final Function(int)? onPageChanged;
  final PageController? controller;

  final List<Widget> Function(BuildContext)? buttonsBuilder;

  const StyledPageDock({super.key, required this.pages, this.onPageChanged, this.controller, this.buttonsBuilder});

  @override
  Widget build(BuildContext context) {
    final pageState = useState(0);

    return StyledDock(
      forceHeight: true,
      activeScrollKey: pageState.value,
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) => PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              onPageChanged: (page) {
                pageState.value = page;
                onPageChanged?.call(page);
              },
              children: pages
                  .mapIndexed(
                    (i, page) => Stack(
                      children: [
                        Positioned.fill(
                          child: KeyedScrollTransformer(
                            scrollKey: i,
                            child: Padding(
                              padding: page.padding,
                              child: SingleChildScrollView(
                                child: SizedBox(
                                  height: page.forceFillHeight ? constraints.maxHeight : null,
                                  child: Column(crossAxisAlignment: .start, children: page.children),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
      buttonsBuilder: buttonsBuilder,
    );
  }
}

class StyledPageDockPage {
  final List<Widget> children;
  final bool forceFillHeight;

  final EdgeInsets padding;

  StyledPageDockPage({
    required this.children,
    this.forceFillHeight = false,
    this.padding = const .symmetric(horizontal: 16),
  });
}
