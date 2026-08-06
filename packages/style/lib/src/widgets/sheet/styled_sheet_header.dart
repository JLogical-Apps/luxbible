import 'package:flutter/material.dart';
import 'package:style/style.dart';

class StyledSheetHeader extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;

  final bool showDragHandle;

  const StyledSheetHeader({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.showDragHandle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        if (showDragHandle)
          SizedBox(
            height: 12,
            child: Align(
              alignment: .bottomCenter,
              child: Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(borderRadius: .circular(999), color: context.colors.borderOpaque),
              ),
            ),
          ),
        gapH8,
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: subtitle == null ? 48 : 52),
          child: Padding(
            padding: .symmetric(horizontal: 8),
            child: Row(
              spacing: 8,
              children: [
                leading ?? gapW48,
                Expanded(
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      if (title case final title?)
                        DefaultTextStyle(
                          style: context.textStyle.headingXs,
                          maxLines: 1,
                          overflow: .ellipsis,
                          child: title,
                        ),
                      if (subtitle case final subtitle?)
                        DefaultTextStyle(
                          style: context.textStyle.paragraphMd.subtle(),
                          maxLines: 1,
                          overflow: .ellipsis,
                          child: subtitle,
                        ),
                    ],
                  ),
                ),
                if (trailing case final trailing?) SizedBox(width: 48, child: trailing) else gapW48,
              ],
            ),
          ),
        ),
        gapH8,
      ],
    );
  }
}
