import 'package:flutter/material.dart';
import 'package:ios_native_code_examples/repository/platform_channel_repository_impl.dart';

class Platform extends InheritedWidget {
  const Platform({
    super.key,
    required this.platformRepository,
    required super.child,
  });

  final PlatformChannelRepositoryImpl platformRepository;

  Future<String> getBatteryLevel() {
    return platformRepository.getBatteryLevel();
  }

  static Platform? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Platform>();
  }

  @override
  bool updateShouldNotify(Platform oldWidget) => true;
}
