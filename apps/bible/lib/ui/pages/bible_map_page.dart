import 'package:bible/models/bible_map.dart';
import 'package:bible/ui/widgets/bible_map_image.dart';
import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class BibleMapPage extends StatelessWidget implements StyledRoute<void> {
  final BibleMap map;

  const BibleMapPage({super.key, required this.map});

  @override
  String get path => '/map';

  @override
  Widget build(BuildContext context) => StyledPage(
    backgroundColor: .backgroundPrimary,
    body: Column(
      crossAxisAlignment: .stretch,
      children: [
        Expanded(
          child: InteractiveViewer(
            maxScale: 6,
            child: Center(
              child: Padding(
                padding: .all(16),
                child: ClipRRect(
                  borderRadius: .circular(12),
                  child: BibleMapImage(map: map),
                ),
              ),
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(color: context.colors.surfacePrimary, boxShadow: [StyledShadow.up(context)]),
          child: SafeArea(
            top: false,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height / 3),
              child: SingleChildScrollView(
                padding: .all(16),
                child: Column(
                  crossAxisAlignment: .stretch,
                  spacing: 8,
                  children: [
                    Text(map.title, style: context.textStyle.headingXs),
                    if (map.caption case final caption?)
                      Text(
                        caption,
                        style: context.textStyle.paragraphMd.copyWith(color: context.colors.contentSecondary),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
