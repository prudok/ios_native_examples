import 'package:flutter/services.dart';

class WidgetKit {
  static const MethodChannel _channel = MethodChannel('flutter_widgetkit');

  static dynamic setItem(String key, dynamic value, String appGroup) async {
    return await _channel.invokeMethod(
      'setItem',
      <String, dynamic>{'key': key, 'value': value, 'appGroup': appGroup},
    );
  }
}
