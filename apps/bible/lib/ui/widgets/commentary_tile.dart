import 'package:bible/models/commentary_type.dart';
import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class CommentaryTile extends StatelessWidget {
  final CommentaryType commentary;
  final Widget? trailing;

  const CommentaryTile({super.key, required this.commentary, this.trailing});

  @override
  Widget build(BuildContext context) => StyledListItem(
    title: commentary.title().toText(),
    subtitle: commentary.description().toText(),
    trailing: trailing,
  );
}
