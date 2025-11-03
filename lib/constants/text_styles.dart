import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  // Main heading
  static const TextStyle mainHeading = TextStyle(
    fontSize: 56,
    fontWeight: FontWeight.w700,
    height: 1.1,
    letterSpacing: -1,
  );
  
  // Subtitle
  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );
  
  // Section heading
  static const TextStyle sectionHeading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );
  
  // See All link
  static const TextStyle linkText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.linkBlue,
  );
}