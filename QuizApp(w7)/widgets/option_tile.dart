import 'package:flutter/material.dart';

// OptionTile widget
Widget optionTile({
  required String option,
  required bool value,
  required ValueChanged<bool?> onChanged,
}) {
  return CheckboxListTile(
    title: Text(option),
    value: value,
    onChanged: onChanged,
  );
}