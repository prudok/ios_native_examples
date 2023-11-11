import 'package:flutter/material.dart';
import 'package:ios_native_code_examples/platform.dart';

class BatteryScreen extends StatelessWidget {
  const BatteryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: Platform.of(context)?.getBatteryLevel(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('Current level: ${snapshot.data}');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            ElevatedButton(
              onPressed: Platform.of(context)?.getBatteryLevel,
              child: const Text('Check battery level again'),
            )
          ],
        ),
      ),
    );
  }
}
