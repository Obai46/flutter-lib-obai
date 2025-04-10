  import 'package:flutter/material.dart';

Widget buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    required String validatorMessage,
    required BuildContext context,
    bool isDouble = false,
  }) {
    return TextFormField(
      style: Theme.of(context).textTheme.headlineMedium,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context).textTheme.headlineMedium,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorMessage;
        }
        if (isDouble == true) {
          final parsedValue = double.tryParse(value);
          if (parsedValue == null) {
            return "الرجاء إدخال رقم صحيح أو عشري";
          }
        }

        return null;
      },
    );
  }
