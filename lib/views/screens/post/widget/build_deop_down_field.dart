import 'package:flutter/material.dart';

Widget buildDropdownField({
  required String label,
  required List<Map<String, String>> items,
  required Function(String?) onChanged,
  required String validatorMessage,
  required BuildContext context,
  required String value,
}) {
  return DropdownButtonFormField<String>(
    
    decoration: InputDecoration(
      labelStyle: Theme.of(context).textTheme.headlineMedium,
      labelText: label,
      border: const OutlineInputBorder(),
    ),
    items: items.map(
      (option) {
        return DropdownMenuItem<String>(
          value: option['value'],
          child: Text(
            option['key']!,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        );
      },
    ).toList(),
    onChanged: onChanged,
    validator: (value) {
      if (value == null) {
        return validatorMessage;
      }

      return null;
    },
    value: items.any((option) => option['value'] == value) ? value : null,
  );
}
