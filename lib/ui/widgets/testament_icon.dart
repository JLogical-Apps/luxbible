import 'package:bible/models/testament.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class TestamentIcon extends StatelessWidget {
  final Testament? testament;

  const TestamentIcon({super.key, required this.testament});

  @override
  Widget build(BuildContext context) => testament == null
      ? Symbols.import_contacts.toIcon()
      : RotatedBox(quarterTurns: testament == .newTestament ? 2 : 0, child: Symbols.side_navigation.toIcon());
}
