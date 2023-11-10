import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformScreen extends StatelessWidget {
  const PlatformScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String viewType = '<platform-view-type>';
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
