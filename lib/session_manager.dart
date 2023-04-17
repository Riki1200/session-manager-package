library session_manager;

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  ButtonStyle? style;
  CustomButton(
      {Key? key, @required this.onPressed, required this.child, this.style})
      : super(key: key) {
    assert(onPressed != null);
    style = TextButton.styleFrom(
      foregroundColor: Colors.white,
      padding: const EdgeInsets.all(16.0),
      backgroundColor: Colors.blue,
      elevation: 9.0,
      textStyle: const TextStyle(
        fontSize: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, style: style, child: child);
  }
}
