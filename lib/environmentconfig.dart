import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnvironmentConfig {
  // String _key = "606a2ff26cf9548f3a737cbdcc727220";
  final movieApiKey = const String.fromEnvironment("movieApiKey");
}

final environmentConfigProvider = Provider<EnvironmentConfig>((ref) {
  return EnvironmentConfig();
});
