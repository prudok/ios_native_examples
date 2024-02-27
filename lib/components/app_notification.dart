import 'dart:async';

import 'package:flutter/material.dart';

final class AppNotification {
  static final AppNotification _internalSingleton = AppNotification._internal();
  factory AppNotification() => _internalSingleton;
  AppNotification._internal();

  final manager = _NotificationManager();
  void error(BuildContext context, String message) {
    manager.run(context, message);
  }
}

final class _NotificationManager {
  bool _isShowing = false;
  OverlayEntry? _overlayEntry;

  Future<void> run(BuildContext context, String message) async {
    if (!_isShowing) {
      _isShowing = true;
      OverlayState? overlayState = Overlay.of(context);
      _overlayEntry = OverlayEntry(
        builder: (_) => _NotificationWidget(message: message),
      );
      final entry = _overlayEntry;
      if (entry != null) {
        overlayState.insert(entry);
        await Future.delayed(const Duration(seconds: 4), () {
          _overlayEntry?.remove();
          _isShowing = false;
        });
      }
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isShowing = false;
      await run(context, message);
    }
  }
}

class _NotificationWidget extends StatefulWidget {
  const _NotificationWidget({Key? key, required this.message})
      : super(key: key);
  final String message;

  @override
  State<_NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<_NotificationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  static const Curve curve = Curves.easeOut;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _playAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        return AnimatedPositioned(
          curve: curve,
          top: 140 * (_controller.value - 0.5),
          duration: const Duration(milliseconds: 300),
          child: child!,
        );
      },
      animation: _controller,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width - 48,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ColoredBox(
              color: Theme.of(context).colorScheme.error,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.error,
                      color: Colors.white,
                      size: 15,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.message,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playAnimation() async {
    await _controller.forward();
    await Future<void>.delayed(const Duration(seconds: 2));
    await _controller.reverse();
  }
}
