import 'package:flutter/material.dart';

class PROInputDecoration {

  textInputDecoration({
    required String label,
    String? hint,
    IconData? icon,
    IconButton? suffixIconButton,
    bool enabled = true,

  }) {
    return InputDecoration(
      label: Text(label),
      hintText: hint,
      prefixIcon: Icon(icon),
      suffixIcon: suffixIconButton,
      enabled: enabled,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12)
      )

    );
  }

}