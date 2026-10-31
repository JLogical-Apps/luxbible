import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class LinkedStudyPanel extends HookWidget {
  final Widget? subtitle;
  final Widget? trailing;
  final Function() onClose;

  final ChapterPassage passage;
  final Reference? passageTopReference;
  final ScrollController scrollController;

  final Function(Reference) onScrollMainToReference;
  final Function(Reference, double panelHeight) onScrollPanelToReference;
  final Reference? Function(double viewportTop, double viewportBottom) getTopVisibleReference;

  final bool isActive;
  final bool isContentLoaded;
  final bool showDragHandle;

  final Widget child;

  const LinkedStudyPanel({
    super.key,
    this.subtitle,
    this.trailing,
    required this.onClose,
    required this.passage,
    required this.passageTopReference,
    required this.scrollController,
    required this.onScrollMainToReference,
    required this.onScrollPanelToReference,
    required this.getTopVisibleReference,
    required this.isActive,
    required this.isContentLoaded,
    required this.showDragHandle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final panelViewportKey = useMemoized(() => GlobalKey());

    final topReferenceState = useState(passageTopReference);
    final ownsScrollRef = useRef(false);

    usePostFrameEffect(() async {
      if (!isActive) return;

      final reference = passageTopReference;
      if (reference != null && !ownsScrollRef.value) {
        topReferenceState.value = reference;
      }

      if (!isContentLoaded || ownsScrollRef.value) {
        return;
      }

      final viewportHeight = panelViewportKey.renderBox?.size.height;
      if (reference == null || viewportHeight == null) {
        return;
      }

      onScrollPanelToReference(reference, viewportHeight);
    }, [passageTopReference, isContentLoaded, isActive]);

    useOnListenableChange(isActive ? scrollController : null, () async {
      if (!isActive) return;

      final topReference = getTopVisibleReference(
        panelViewportKey.globalBounds?.top ?? 0,
        panelViewportKey.globalBounds?.bottom ?? 0,
      );
      if (topReference != null) topReferenceState.value = topReference;
    });

    usePostFrameEffect(() {
      final topReference = topReferenceState.value;
      if (topReference != passageTopReference && topReference != null && ownsScrollRef.value) {
        onScrollMainToReference(topReference);
      }
    }, [useDebounced<Reference?>(topReferenceState.value, Duration(milliseconds: 100))]);

    return TapRegion(
      onTapInside: (_) => ownsScrollRef.value = true,
      onTapOutside: (_) => ownsScrollRef.value = false,
      child: Container(
        decoration: BoxDecoration(color: context.colors.surfacePrimary, borderRadius: .circular(16)),
        child: Column(
          children: [
            StyledSheetHeader(
              title: passage.format().toText(),
              subtitle: subtitle,
              leading: StyledCircleButton.md(child: Symbols.close.toIcon(), onPressed: onClose),
              trailing: trailing,
            ),
            StyledDivider(height: 2),
            Expanded(
              child: KeyedSubtree(key: panelViewportKey, child: child),
            ),
          ],
        ),
      ),
    );
  }
}
