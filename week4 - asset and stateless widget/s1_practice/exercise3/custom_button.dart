import 'package:flutter/material.dart';

enum ButtonType { primary, secondary, disabled }

enum IconPosition { beforeLabel, afterLabel }

class CustomButton extends StatelessWidget {
  final String label;
  final Icon iconData;
  final IconPosition iconPosition;
  final ButtonType buttonType;

  const CustomButton(
      {super.key,
      required this.label,
      required this.iconData,
      this.iconPosition = IconPosition.beforeLabel,
      this.buttonType = ButtonType.primary});

  Color _getBtnColor(){
    switch (buttonType){
      case ButtonType.primary:
        return Colors.blue;
      case ButtonType.secondary:
        return Colors.green;
      case ButtonType.disabled:
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: buttonType == ButtonType.disabled ? null : () {},
      style: TextButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: _getBtnColor(),
        textStyle: const TextStyle(fontSize: 20),
      ),
      child: iconPosition == IconPosition.beforeLabel
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                iconData,
                const SizedBox(width: 10),
                Text(label),
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label),
                const SizedBox(width: 10),
                iconData,
              ],
            ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Custom Button"),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                label: "Primary Button",
                iconData: Icon(Icons.add),
                buttonType: ButtonType.primary,
                iconPosition: IconPosition.afterLabel,
              ),
              SizedBox(height: 20),
              CustomButton(
                label: "Secondary Button",
                iconData: Icon(Icons.remove),
                buttonType: ButtonType.secondary,
              ),
              SizedBox(height: 20),
              CustomButton(
                label: "Disabled Button",
                iconData: Icon(Icons.close),
                buttonType: ButtonType.disabled,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
