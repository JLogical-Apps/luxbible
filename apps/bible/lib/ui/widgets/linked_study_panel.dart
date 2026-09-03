import 'package:bible/ui/widgets/visible_verse_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class LinkedStudyPanel extends HookWidget {
  final Widget? subtitle;
  final Widget? trailing;
  final Function() onClose;

  final ChapterReference chapterReference;
  final Reference? passageTopReference;

  final Function(Reference) onScrollMainToReference;
  final Function(Reference, double panelHeight, PassageController) onScrollPanelToReference;

  final bool isActive;
  final bool showDragHandle;

  final Widget Function(BuildContext, PassageController, Function() onContentLoaded) builder;

  const LinkedStudyPanel({
    super.key,
    this.subtitle,
    this.trailing,
    required this.onClose,
    required this.chapterReference,
    required this.passageTopReference,
    required this.onScrollMainToReference,
    required this.onScrollPanelToReference,
    required this.isActive,
    required this.showDragHandle,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final controller = usePassageController(chapterReference);
    final scrollController = controller.scrollController;
    final panelViewportKey = useMemoized(() => GlobalKey());

    final topReferenceState = useState(passageTopReference);
    final isContentLoadedState = useState(false);

    final ownsScrollRef = useRef(false);

    usePostFrameEffect(() async {
      if (!isActive) return;

      final reference = passageTopReference;
      if (reference != null && !ownsScrollRef.value) {
        topReferenceState.value = reference;
      }

      if (!isContentLoadedState.value || ownsScrollRef.value) {
        return;
      }

      final viewportHeight = panelViewportKey.renderBox?.size.height;
      if (reference == null || viewportHeight == null) {
        return;
      }

      onScrollPanelToReference(reference, viewportHeight, controller);
    }, [passageTopReference, isContentLoadedState.value, isActive]);

    useOnListenableChange(isActive ? scrollController : null, () async {
      if (!isActive) return;

      final visibleReferences = getVisibleReferencesInViewport(
        keyByReference: controller.keyByReference,
        viewportTop: panelViewportKey.globalBounds?.top ?? 0,
        viewportBottom: panelViewportKey.globalBounds?.bottom ?? 0,
      );
      if (visibleReferences.isEmpty) return;

      topReferenceState.value = visibleReferences.firstOrNull;
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
              title: chapterReference.format().toText(),
              subtitle: subtitle,
              leading: StyledCircleButton.md(child: Symbols.close.toIcon(), onPressed: onClose),
              trailing: trailing,
            ),
            StyledDivider(height: 2),
            Expanded(
              child: KeyedSubtree(
                key: panelViewportKey,
                child: builder(context, controller, () => isContentLoadedState.value = true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
