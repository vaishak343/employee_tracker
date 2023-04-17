import 'package:flutter/material.dart';

import '../utils/utils.dart';

class ActionBtnWidget extends StatelessWidget {
  const ActionBtnWidget({
    super.key,
    required this.actionText,
    required this.onPressed,
    required this.type,
    required this.forDialog,
  });

  final String actionText;
  final VoidCallback onPressed;
  final ActionBtnType type;
  final bool forDialog;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: forDialog ? const EdgeInsets.all(4) : null,
        backgroundColor: type == ActionBtnType.cancel
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.primary,
      ),
      onPressed: onPressed,
      child: Text(
        actionText,
        style: TextStyle(
          fontSize: forDialog ? 12 : null,
          color: type == ActionBtnType.cancel
              ? Theme.of(context).colorScheme.onPrimaryContainer
              : Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
