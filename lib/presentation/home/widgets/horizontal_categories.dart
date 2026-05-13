import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../blocs/language/language_bloc.dart';
import '../../blocs/language/language_state.dart';
import '../../vegetables/vegetable_screen.dart';
import '../../egg/egg_screen.dart';
import '../../fuel/fuel_screen.dart';
import '../../gold/gold_screen.dart';

class CatData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Widget Function() routeBuilder;
  final String img;

  CatData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.routeBuilder,
    required this.img,
  });
}

class HorizontalCategories extends StatelessWidget {
  const HorizontalCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        final categories = [
          CatData(
              title: state.isEnglish ? 'Vegetables' : 'காய்கறிகள்',
              subtitle: state.isEnglish ? 'Fresh' : 'புதியவை',
              icon: Icons.eco_rounded,
              color: AppColors.vegetable,
              routeBuilder: () => const VegetableScreen(),
              img: '🥬'),
          CatData(
              title: state.isEnglish ? 'Egg & Meat' : 'முட்டை & இறைச்சி',
              subtitle: state.isEnglish ? 'Daily' : 'தினசரி',
              icon: Icons.egg_rounded,
              color: AppColors.egg,
              routeBuilder: () => const EggScreen(),
              img: '🥚'),
          CatData(
              title: state.isEnglish ? 'Fuel' : 'எரிபொருள்',
              subtitle: state.isEnglish ? 'Live' : 'நேரடி',
              icon: Icons.local_gas_station_rounded,
              color: AppColors.fuel,
              routeBuilder: () => const FuelScreen(),
              img: '⛽'),
          CatData(
              title: state.isEnglish ? 'Gold' : 'தங்கம்',
              subtitle: state.isEnglish ? 'Rates' : 'விலை',
              icon: Icons.diamond_rounded,
              color: AppColors.gold,
              routeBuilder: () => const GoldScreen(),
              img: '🪙'),
        ];

        return SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, i) {
              final cat = categories[i];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => cat.routeBuilder()));
                },
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.cardBorder, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              cat.color.withValues(alpha: 0.3),
                              cat.color.withValues(alpha: 0.1)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child:
                              Text(cat.img, style: const TextStyle(fontSize: 24)),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        cat.title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        cat.subtitle,
                        style: TextStyle(
                          fontSize: 10,
                          color: cat.color,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }
    );
  }
}
