import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTypography {
  const AppTypography._();
  static const h2 = TextStyle(
    fontSize: 24,
    color: AppColors.blueGrey,
    fontWeight: FontWeight.w500,
  );
  static const h3 = TextStyle(
    fontSize: 18,
    color: AppColors.black,
    fontWeight: FontWeight.w500,
  );
  static final h3Bold = h3.copyWith(
    fontWeight: FontWeight.bold,
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
  static final pSmallBlueGrey = pSmall.copyWith(
    color: AppColors.blueGrey,
  );
  static const pSBlue = TextStyle(
    color: AppColors.blue,
  );
}
