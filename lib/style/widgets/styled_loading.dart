import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:bible/style/style.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StyledLoading extends StatelessWidget {
  final Widget? child;

  const StyledLoading({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    final textStyle = DefaultTextStyle.of(context);
    return AnimatedSizeAndFade(
      alignment: .topLeft,
      fadeInCurve: Curves.easeInOutCubic,
      fadeOutCurve: Curves.easeInOutCubic,
      sizeCurve: Curves.easeInOutCubic,
      child: Align(
        alignment: .topLeft,
        child:
            child ??
            Shimmer.fromColors(
              key: ValueKey('empty'),
              baseColor: context.colors.contentDisabled.withValues(alpha: 0.5),
              highlightColor: context.colors.contentDisabled.withValues(alpha: 0.2),
              period: Duration(seconds: 2),
              child: Container(
                width: double.infinity,
                height: textStyle.style.fontSize!,
                decoration: BoxDecoration(color: Colors.black, borderRadius: .circular(4)),
                margin: .only(bottom: (textStyle.style.totalHeight - textStyle.style.fontSize!)),
              ),
            ),
      ),
    );
  }
}
