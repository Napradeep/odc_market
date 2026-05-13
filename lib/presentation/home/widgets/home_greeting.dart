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
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    
    final now = DateTime.now();
    final dayStr = DateFormat('EEEE, dd MMM').format(now);
    final hour = now.hour;

    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        String greeting = state.isEnglish ? 'Good Morning' : 'இனிய காலை வணக்கம்';
        IconData greetingIcon = Icons.wb_sunny_rounded;
        Color iconColor = Colors.orangeAccent;

        if (hour >= 12 && hour < 17) {
          greeting = state.isEnglish ? 'Good Afternoon' : 'இனிய மதிய வணக்கம்';
          greetingIcon = Icons.light_mode_rounded;
          iconColor = Colors.orange;
        } else if (hour >= 17 && hour < 21) {
          greeting = state.isEnglish ? 'Good Evening' : 'இனிய மாலை வணக்கம்';
          greetingIcon = Icons.wb_twilight_rounded;
          iconColor = Colors.deepOrange;
        } else if (hour >= 21 || hour < 5) {
          greeting = state.isEnglish ? 'Good Night' : 'இனிய இரவு வணக்கம்';
          greetingIcon = Icons.nightlight_round_rounded;
          iconColor = Colors.indigoAccent;
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greeting,
                    style: TextStyle(
                      fontSize: isTablet ? 32 : 26,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                      letterSpacing: -1,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_rounded, 
                        size: 14, 
                        color: AppColors.textMuted.withValues(alpha: 0.7)
                      ),
                      const SizedBox(width: 6),
                      Text(
                        state.isEnglish ? 'Market rates for $dayStr' : '$dayStr சந்தை நிலவரம்',
                        style: TextStyle(
                          fontSize: isTablet ? 16 : 13,
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: EdgeInsets.all(isTablet ? 16 : 12),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(isTablet ? 24 : 20),
                border: Border.all(color: iconColor.withValues(alpha: 0.15), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: iconColor.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                greetingIcon,
                color: iconColor, 
                size: isTablet ? 36 : 30
              ),
            ),
          ],
        );
      },
    );
  }
}
