import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import 'price_indicator.dart';

class PriceTile extends StatelessWidget {
  final String tamilName;
  final String englishName;
  final double todayPrice;
  final double yesterdayPrice;
  final String unit;
  final Color? accentColor;

  const PriceTile({
    super.key,
    required this.tamilName,
    required this.englishName,
    required this.todayPrice,
    required this.yesterdayPrice,
    this.unit = 'kg',
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final diff = todayPrice - yesterdayPrice;
    final color = accentColor ?? AppColors.primaryLight;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder, width: 1),
      ),
      child: Row(
        children: [
          // Left accent bar
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 14),

          // Names
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tamilName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  englishName,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),

          // Price & Indicator
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${AppConstants.currency}${todayPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '/$unit',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(width: 6),
                  PriceIndicator(diff: diff),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FuelPriceTile extends StatelessWidget {
  final String tamilName;
  final String englishName;
  final double price;
  final double yesterdayPrice;
  final Color accentColor;
  final IconData icon;

  const FuelPriceTile({
    super.key,
    required this.tamilName,
    required this.englishName,
    required this.price,
    required this.yesterdayPrice,
    required this.accentColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final diff = price - yesterdayPrice;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accentColor.withValues(alpha: 0.2),
            AppColors.surfaceLight,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accentColor.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: accentColor.withValues(alpha: 0.4)),
            ),
            child: Icon(icon, color: accentColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tamilName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    )),
                Text(englishName,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    )),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${AppConstants.currency}${price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const Text(
                'per litre',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 4),
              PriceIndicator(diff: diff),
            ],
          ),
        ],
      ),
    );
  }
}

class GoldPriceTile extends StatelessWidget {
  final String tamilName;
  final String englishName;
  final double price;
  final double yesterdayPrice;
  final String unit;

  const GoldPriceTile({
    super.key,
    required this.tamilName,
    required this.englishName,
    required this.price,
    required this.yesterdayPrice,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final diff = price - yesterdayPrice;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accentLight.withValues(alpha: 0.1),
            AppColors.surfaceLight,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.accentLight.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('✨', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tamilName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        )),
                    Text(englishName,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        )),
                  ],
                ),
              ),
              PriceIndicator(diff: diff),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${AppConstants.currency}${price.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentLight,
                ),
              ),
              Text(
                '/ $unit',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'நேற்று: ${AppConstants.currency}${yesterdayPrice.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
