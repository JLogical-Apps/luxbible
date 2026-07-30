import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/visible_verse_utils.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/key_extensions.dart';
import 'package:bible/utils/hook_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:utils_core/utils_core.dart';

class LinkedStudyPanel extends HookWidget {
  final Widget? subtitle;
  final Function() onClose;

  final ChapterReference chapterReference;
  final Reference? passageTopReference;
  final Function(Reference) onScrollToReference;

  final bool isActive;
  final bool showDragHandle;

  final List<Widget> Function(
    BuildContext,
    WidgetRef,
    Map<Reference, GlobalKey> keyByReference,
    Map<Reference, GlobalKey> keyBySectionReference,
    Function() onContentLoaded,
  )
  childrenBuilder;

  const LinkedStudyPanel({
    super.key,
    this.subtitle,
    required this.onClose,
    required this.chapterReference,
    required this.passageTopReference,
    required this.onScrollToReference,
    required this.isActive,
    required this.showDragHandle,
    required this.childrenBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final panelKeyByReference = useMemoized(
      () => chapterReference.references.mapToMap((reference) => MapEntry(reference, GlobalKey())),
      [chapterReference],
    );
    final panelKeyBySectionReference = useMemoized(
      () => chapterReference.references.mapToMap((reference) => MapEntry(reference, GlobalKey())),
      [chapterReference],
    );
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

      final key = panelKeyBySectionReference[reference]?.currentContext != null
          ? panelKeyBySectionReference[reference]
          : panelKeyByReference[reference];
      if (key != null) {
        key.scrollIntoView(
          axis: .vertical,
          duration: Duration(milliseconds: 200),
          alignment: key == panelKeyBySectionReference[reference] ? (32 / viewportHeight) : 0,
        );
      }
    }, [passageTopReference, isContentLoadedState.value, isActive]);

    useOnPostFrameListenableChange(isActive ? scrollController : null, () async {
      if (!isActive) return;

      final visibleReferences = getVisibleReferencesInViewport(
        keyByReference: panelKeyByReference,
        viewportTop: panelViewportKey.globalBounds?.top ?? 0,
        viewportBottom: panelViewportKey.globalBounds?.bottom ?? 0,
      );
      if (visibleReferences.isEmpty) return;

      final topReference = topReferenceState.value;
      topReferenceState.value = visibleReferences.firstOrNull;
      if (topReference != passageTopReference && topReference != null && ownsScrollRef.value) {
        onScrollToReference(topReference);
      }
    }, [MediaQuery.sizeOf(context)]);

    return TapRegion(
      onTapInside: (_) => ownsScrollRef.value = true,
      onTapOutside: (_) => ownsScrollRef.value = false,
      child: StyledSheet.builder(
        showDragHandle: showDragHandle,
        title: chapterReference.format().toText(),
        subtitle: subtitle,
        controller: scrollController,
        leading: StyledCircleButton.md(child: Symbols.close.toIcon(), onPressed: onClose),
        childrenKey: panelViewportKey,
        childrenBuilder: (context, ref) => childrenBuilder(
          context,
          ref,
          panelKeyByReference,
          panelKeyBySectionReference,
          () => isContentLoadedState.value = true,
        ),
      ),
    );
  }
}
