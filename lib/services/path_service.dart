import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'path_service.g.dart';

@Riverpod(keepAlive: true)
Paths pathService(Ref ref) => throw UnimplementedError();

class Paths {
  final Directory applicationSupport;

  const Paths({required this.applicationSupport});
}

Future<Paths> getPaths() async {
  return Paths(applicationSupport: await getApplicationSupportDirectory());
}
