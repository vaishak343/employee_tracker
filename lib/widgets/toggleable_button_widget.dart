import 'package:flutter/material.dart';

class ToggleableButtonWidget extends StatefulWidget {
  const ToggleableButtonWidget({super.key});

  @override
  ToggleableButtonWidgetState createState() => ToggleableButtonWidgetState();
}

class ToggleableButtonWidgetState extends State<ToggleableButtonWidget> {
  bool _isPressed = false;

  void _toggleButtonState() {
    setState(() {
      _isPressed = !_isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _toggleButtonState,
      style: ElevatedButton.styleFrom(
        backgroundColor: _isPressed
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.primaryContainer,
        elevation: _isPressed ? 8 : 2,
      ),
      child: Text(
        _isPressed ? 'Pressed' : 'Not Pressed',
        style: TextStyle(
            color: _isPressed
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
