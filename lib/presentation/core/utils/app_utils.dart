import 'package:flutter/material.dart';
import 'package:investor_app/presentation/core/theme/app_theme.dart';


class AppUtils {
  static Color getRiskColor(String risk) {
    switch (risk.toLowerCase()) {
      case 'low':
        return AppColors.riskLow;
      case 'medium':
        return AppColors.riskMedium;
      case 'high':
        return AppColors.riskHigh;
      default:
        return AppColors.textSecondary;
    }
  }

  static String formatInr(double amount) {
    if (amount >= 10000000) {
      return '₹${(amount / 10000000).toStringAsFixed(1)}Cr';
    } else if (amount >= 100000) {
      return '₹${(amount / 100000).toStringAsFixed(1)}L';
    }
    return '₹${amount.toStringAsFixed(0)}';
  }

  static List<String> get industries =>
      ['CleanTech', 'HealthTech', 'RetailTech', 'EdTech', 'AgriTech', 'LegalTech'];

  static List<String> get riskLevels => ['Low', 'Medium', 'High'];
}