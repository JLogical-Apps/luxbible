import 'package:style/style.dart';
import 'package:bible/ui/widgets/bible_body.dart';
import 'package:flutter/material.dart';

class BiblePage extends StatelessWidget {
  const BiblePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StyledPage(backgroundColor: .backgroundPrimary, body: BibleBody());
  }
}
