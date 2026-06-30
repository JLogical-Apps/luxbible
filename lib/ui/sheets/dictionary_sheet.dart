import 'package:bible/models/dictionary_entry.dart';
import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:flutter/material.dart';

class DictionarySheet {
  static Future<void> show(BuildContext context, {required DictionaryEntry entry}) => context.showStyledSheet(
    (context) => StyledSheet(
      title: entry.title.toText(),
      subtitle: "Easton's Bible Dictionary".toText(),
      children: [
        Padding(
          padding: .all(16),
          child: Text(entry.definition, style: context.textStyle.paragraphSm),
        ),
      ],
    ),
  );
}
