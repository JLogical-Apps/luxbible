import 'package:bible/models/commentary.dart';
import 'package:bible/models/commentary_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'commentaries_provider.g.dart';

@Riverpod(keepAlive: true)
Map<CommentaryType, Commentary> commentaries(Ref ref) => throw UnimplementedError();
