library session_manager;

import 'dart:async';
import 'dart:html' if (dart.library.html) 'dart:html';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

// import 'package:session_screen_manager/session_manager.dart';
// this is the widget that will be used to wrap the app
class SessionActivityManager extends StatefulWidget {
  final Widget child;

  final void Function()? onSessionExpired;
  final void Function(Timer?)? onSessionTimeout;
  final void Function(AppLifecycleState state)? onSessionActivity;
  final Duration sessionTimeout;
  final HitTestBehavior? behavior;

  const SessionActivityManager({
    Key? key,
    required this.child,
    this.onSessionExpired,
    this.onSessionTimeout,
    this.onSessionActivity,
    this.sessionTimeout = const Duration(minutes: 5),
    this.behavior = HitTestBehavior.deferToChild,
  }) : super(key: key);

  @override
  SessionActivityManagerState createState() => SessionActivityManagerState();
}

class SessionActivityManagerState extends State<SessionActivityManager>
    with WidgetsBindingObserver {
  Timer? _timer = null;
  final FocusNode focusNode = FocusNode();

  HitTestBehavior defualtBehavior = HitTestBehavior.translucent;

  @override
  void initState() {
    if (kIsWeb) {
      window.addEventListener('focus', (e) {
        didChangeAppLifecycleState(AppLifecycleState.resumed);
      });
      window.addEventListener('blur', (e) {
        didChangeAppLifecycleState(AppLifecycleState.paused);
      });
    } else {
      WidgetsBinding.instance.addObserver(this);
    }
    super.initState();
    _initializeTimer();
  }

  @override
  void didChangeMetrics() {
    setState(() {
      [];
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) =>
      widget.onSessionActivity?.call(state);

  @override
  void dispose() {
    if (kIsWeb) {
      window.removeEventListener('focus', (e) {
        didChangeAppLifecycleState(AppLifecycleState.resumed);
      });
      window.removeEventListener('blur', (e) {
        didChangeAppLifecycleState(AppLifecycleState.paused);
      });
    } else {
      WidgetsBinding.instance.removeObserver(this);
    }
    super.dispose();
  }

  Widget build(BuildContext context) => Listener(
      key: widget.key,
      onPointerMove: (event) {
        _handleUserInteraction();
      },
      behavior: widget.behavior ?? defualtBehavior,
      child: GestureDetector(
        key: const Key('session_manager'),
        onTap: () => _handleUserInteraction(),
        onPanDown: (_) => _handleUserInteraction(),
        onScaleStart: (_) => _handleUserInteraction(),
        behavior: defualtBehavior,
        child: widget.child,
      ));

  void _handleUserInteraction() {
    _initializeTimer();
  }

  void _initializeTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(widget.sessionTimeout, (timer) {
      widget.onSessionExpired?.call();
    });

    widget.onSessionTimeout?.call(_timer);
  }
}
