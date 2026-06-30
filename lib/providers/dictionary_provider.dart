import 'package:bible/models/dictionary_entry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dictionary_provider.g.dart';

@Riverpod(keepAlive: true)
Map<String, DictionaryEntry> dictionary(Ref ref) => throw UnimplementedError();
