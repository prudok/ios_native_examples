import 'package:flutter/services.dart';
import 'package:ios_native_code_examples/repository/platform_channel_repository.dart';

class PlatformChannelRepositoryImpl extends PlatformChannelRepository {
  final MethodChannel channel = const MethodChannel('samples.ios.examples');

  @override
  Future<String> getBatteryLevel() async {
    try {
      final result = await channel.invokeMethod<int>('getBatteryLevel');
      return 'Battery level: $result%';
    } on Object catch (error) {
      return "Failed to get battery level: $error";
    }
  }
}
