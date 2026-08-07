import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';

class TestamentIcon extends StatelessWidget {
  final Testament? testament;

  const TestamentIcon({super.key, required this.testament});

  @override
  Widget build(BuildContext context) => testament == null
      ? Symbols.import_contacts.toIcon()
      : RotatedBox(quarterTurns: testament == .newTestament ? 2 : 0, child: Symbols.side_navigation.toIcon());
}
