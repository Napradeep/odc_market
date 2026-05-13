import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../blocs/language/language_bloc.dart';
import '../../blocs/language/language_state.dart';

class HomeGreeting extends StatelessWidget {
  const HomeGreeting({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dayStr = DateFormat('EEEE, dd MMM').format(now);
    final hour = now.hour;

    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        String greeting = state.isEnglish ? 'Good Morning' : 'இனிய காலை வணக்கம்';
        if (hour >= 12 && hour < 17) {
          greeting = state.isEnglish ? 'Good Afternoon' : 'இனிய மதிய வணக்கம்';
        } else if (hour >= 17) {
          greeting = state.isEnglish ? 'Good Evening' : 'இனிய மாலை வணக்கம்';
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  state.isEnglish ? 'Market rates for $dayStr' : '$dayStr சந்தை நிலவரம்',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
              ),
              child: const Icon(Icons.wb_sunny_rounded,
                  color: AppColors.accentLight, size: 28),
            ),
          ],
        );
      },
    );
  }
}
