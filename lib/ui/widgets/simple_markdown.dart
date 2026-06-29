import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class SimpleMarkdown extends StatelessWidget {
  final String text;

  const SimpleMarkdown({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: text
            .split('*')
            .mapIndexed(
              (index, segment) => TextSpan(
                text: segment,
                style: index.isOdd ? TextStyle(fontStyle: .italic) : null,
              ),
            )
            .toList(),
      ),
    );
  }
}
