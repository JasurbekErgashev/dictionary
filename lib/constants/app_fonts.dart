import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTypography {
  const AppTypography._();
  static const h2 = TextStyle(
    fontSize: 24,
    color: AppColors.blueGrey,
    fontWeight: FontWeight.w500,
  );
  static const p = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const pSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );
}
