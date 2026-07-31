import 'package:bible/functions/commentary_importer.dart';
import 'package:bible/models/commentary.dart';
import 'package:bible/models/commentary_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'commentary_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Commentary> commentary(Ref ref, {required CommentaryType type}) => CommentaryImporter().import(type: type);
