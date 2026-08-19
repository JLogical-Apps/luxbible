import 'package:bible/models/user/language.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'language_provider.g.dart';

@Riverpod(keepAlive: true)
Language language(Ref ref) => Language.device;
