import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    WidgetsBinding.instance.addObserver(this);
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
    WidgetsBinding.instance.removeObserver(this);
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
        // ... repeat this for all gesture events
        behavior: HitTestBehavior.translucent,
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
