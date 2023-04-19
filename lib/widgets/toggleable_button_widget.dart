import 'package:flutter/material.dart';
import '../utils/utils.dart';

class ToggleableButtonWidget extends StatefulWidget {
  const ToggleableButtonWidget({
    super.key,
    required this.btnText,
    required this.onPressed,
    required this.isSelected,
  });

  final DateOptions btnText;
  final VoidCallback onPressed;
  final bool isSelected;

  @override
  ToggleableButtonWidgetState createState() => ToggleableButtonWidgetState();
}

class ToggleableButtonWidgetState extends State<ToggleableButtonWidget> {
  // void _toggleButtonState() {
  //   setState(() {
  //     _isPressed = !_isPressed;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _isPressed = widget.btnText ==
  //       context.read<AddEmployeeCubit>().state.selectedDateOption;
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        
        onPressed: () {
          // _toggleButtonState();
          widget.onPressed();
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(4.0),
          backgroundColor: widget.isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Text(
          widget.btnText.string,
          style: TextStyle(
              color: widget.isSelected
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
