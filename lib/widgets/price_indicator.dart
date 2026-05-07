import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';

class PriceIndicator extends StatelessWidget {
  final double diff;
  final bool showPercent;
  final double fontSize;

  const PriceIndicator({
    super.key,
    required this.diff,
    this.showPercent = false,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    if (diff == 0) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.remove, size: 14, color: AppColors.priceStable),
          const SizedBox(width: 2),
          Text(
            'Stable',
            style: TextStyle(
              fontSize: fontSize,
              color: AppColors.priceStable,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }

    final isUp = diff > 0;
    final color = isUp ? AppColors.priceUp : AppColors.priceDown;
    final icon =
        isUp ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded;
    final sign = isUp ? '+' : '';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 2),
          Text(
            '$sign${AppConstants.currency}${diff.abs().toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: fontSize,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
