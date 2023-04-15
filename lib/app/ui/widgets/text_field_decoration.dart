import 'package:dictionary/constants/constants.dart';
import 'package:flutter/material.dart';

InputDecoration appTextFieldDecoration({
  String? hintText,
  Widget? prefixIcon,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    hintText: hintText,
    filled: true,
    fillColor: AppColors.white,
    contentPadding: const EdgeInsets.all(14),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.lightPeriwinkle),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.periwinkle),
    ),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
  );
}
