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
  GridPriceData(this.name, this.category, this.price, this.diff, this.unit, this.emoji);
}

class LivePriceCard extends StatelessWidget {
  final GridPriceData data;

  const LivePriceCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, langState) {
        final isUp = data.diff > 0;
        final isDown = data.diff < 0;
        final diffColor = isUp ? AppColors.priceUp : isDown ? AppColors.priceDown : AppColors.priceStable;
        final diffIcon = isUp ? Icons.trending_up_rounded : isDown ? Icons.trending_down_rounded : Icons.trending_flat_rounded;

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
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.cardBorder.withValues(alpha: 0.5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                top: -20,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(alpha: 0.03),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.emoji, style: const TextStyle(fontSize: 28)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          decoration: BoxDecoration(
                            color: diffColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(diffIcon, size: 12, color: diffColor),
                              const SizedBox(width: 4),
                              Text(
                                '${data.diff > 0 ? '+' : ''}${data.diff.toStringAsFixed(1)}',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: diffColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translatedCategory,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textMuted,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          data.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${AppConstants.currency}${data.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3.0, left: 2.0),
                              child: Text(
                                '/$translatedUnit',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textMuted,
                                  fontWeight: FontWeight.w500,
                                ),
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
      }
    );
  }
}
