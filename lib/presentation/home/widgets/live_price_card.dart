import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../blocs/language/language_bloc.dart';
import '../../blocs/language/language_state.dart';

class GridPriceData {
  final String name;
  final String category;
  final double price;
  final double diff;
  final String unit;
  final String emoji;
  GridPriceData(
      this.name, this.category, this.price, this.diff, this.unit, this.emoji);
}

class LivePriceCard extends StatelessWidget {
  final GridPriceData data;

  const LivePriceCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, langState) {
      final isUp = data.diff > 0;
      final isDown = data.diff < 0;
      final diffColor = isUp
          ? AppColors.priceUp
          : isDown
              ? AppColors.priceDown
              : AppColors.priceStable;
      final diffIcon = isUp
          ? Icons.trending_up_rounded
          : isDown
              ? Icons.trending_down_rounded
              : Icons.trending_flat_rounded;

      String translatedCategory = data.category;
      if (!langState.isEnglish) {
        if (data.category == 'Vegetables') translatedCategory = 'காய்கறிகள்';
        if (data.category == 'Poultry') translatedCategory = 'கோழிப்பண்ணை';
        if (data.category == 'Fuel') translatedCategory = 'எரிபொருள்';
      }

      String translatedUnit = data.unit;
      if (!langState.isEnglish) {
        if (data.unit == 'kg') translatedUnit = 'கிலோ';
        if (data.unit == 'pc') translatedUnit = 'முட்டை';
        if (data.unit == 'L') translatedUnit = 'லிட்டர்';
      }

      return Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.08),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.04),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Subtle background gradient element
            Positioned(
              right: -30,
              top: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.06),
                      AppColors.primary.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(isTablet ? 20.0 : 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(data.emoji,
                            style: TextStyle(fontSize: isTablet ? 32 : 28)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: diffColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(diffIcon, size: 14, color: diffColor),
                            const SizedBox(width: 4),
                            Text(
                              '${data.diff > 0 ? '+' : ''}${data.diff.toStringAsFixed(1)}',
                              style: TextStyle(
                                fontSize: isTablet ? 12 : 11,
                                fontWeight: FontWeight.w800,
                                color: diffColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.textMuted.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          translatedCategory.toUpperCase(),
                          style: TextStyle(
                            fontSize: isTablet ? 11 : 9,
                            color: AppColors.textMuted,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        data.name,
                        style: TextStyle(
                          fontSize: isTablet ? 20 : 17,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                          height: 1.1,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            AppConstants.currency,
                            style: TextStyle(
                              fontSize: isTablet ? 16 : 14,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                data.price.toStringAsFixed(2),
                                style: TextStyle(
                                  fontSize: isTablet ? 28 : 24,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.textPrimary,
                                  letterSpacing: -1,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '/$translatedUnit',
                            style: TextStyle(
                              fontSize: isTablet ? 13 : 12,
                              color: AppColors.textMuted,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
