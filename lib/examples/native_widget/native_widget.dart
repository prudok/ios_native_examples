import 'package:flutter/material.dart';
import 'package:ios_native_code_examples/examples/native_widget/widget_kit.dart';

class NativeWidget extends StatefulWidget {
  const NativeWidget({super.key});

  @override
  State<NativeWidget> createState() => _NativeWidgetState();
}

class _NativeWidgetState extends State<NativeWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: TextField(controller: _controller),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                WidgetKit.setItem('WidgetData', _controller.text, 'group.ios-widget-flutter');
              },
              child: const Text('Push to widget'),
            )
          ],
        ),
      ),
    );
  }
}
