import 'dart:io';
import 'package:dotenv/dotenv.dart';

final environment = DotEnv(includePlatformEnvironment: true, quiet: true);

void loadEnvironment(String path) => environment
  ..clear()
  ..load([path])
  ..addAll(Platform.environment);

String getEnvironment(String name) => environment[name]?.trim() ?? '';

String getRequiredEnvironment(String name) {
  final value = getEnvironment(name);
  if (value.isEmpty)
    throw FormatException(
      'Configure $name in tools/socials/.env or your environment',
    );
  return value;
}

Iterable<String> getSecrets() => [
  ...Platform.environment.entries
      .where(
        (entry) => RegExp(
          r'TOKEN|SECRET|KEY',
          caseSensitive: false,
        ).hasMatch(entry.key),
      )
      .map((entry) => entry.value),
  getEnvironment('ZERNIO_API_KEY'),
  getEnvironment('WOOPSOCIAL_API_KEY'),
].where((value) => value.isNotEmpty);
