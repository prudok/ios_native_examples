import 'package:flutter/material.dart';
import 'package:ios_native_code_examples/examples/battery_screen.dart';
import 'package:ios_native_code_examples/examples/native_widget/native_widget.dart';
import 'package:ios_native_code_examples/examples/platform_screen.dart';
import 'package:ios_native_code_examples/platform.dart';
import 'package:ios_native_code_examples/repository/platform_channel_repository_impl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Platform(
      platformRepository: PlatformChannelRepositoryImpl(),
      child: MaterialApp(
        title: 'Flutter Ios Native Codes Examples',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const BatteryScreen()),
              ),
              child: const Text('Battery Level'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const PlatformScreen()),
              ),
              child: const Text('Platform Screen'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const NativeWidget()),
              ),
              child: const Text('Native Widget'),
            ),
          ],
        ),
      ),
    );
  }
}
