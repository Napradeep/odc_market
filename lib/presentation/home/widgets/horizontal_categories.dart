import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../blocs/language/language_bloc.dart';
import '../../blocs/language/language_state.dart';
import '../../vegetables/vegetable_screen.dart';
import '../../fuel/fuel_screen.dart';

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
    return BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
      final categories = [
        CatData(
            title: state.isEnglish ? 'Vegetables' : 'காய்கறிகள்',
            subtitle: state.isEnglish ? 'Fresh' : 'புதியவை',
            icon: Icons.eco_rounded,
            color: AppColors.vegetable,
            routeBuilder: () => const VegetableScreen(
                category: 'vegetable',
                title: 'காய்கறிகள்',
                titleEn: 'Vegetables',
                color: AppColors.vegetable),
            img: '🥬'),
        CatData(
            title: state.isEnglish ? 'Fruits' : 'பழங்கள்',
            subtitle: state.isEnglish ? 'Fresh' : 'புதியவை',
            icon: Icons.apple_rounded,
            color: Colors.orange,
            routeBuilder: () => const VegetableScreen(
                category: 'fruit',
                title: 'பழங்கள்',
                titleEn: 'Fruits',
                color: Colors.orange),
            img: '🍎'),
        CatData(
            title: state.isEnglish ? 'Flowers' : 'பூக்கள்',
            subtitle: state.isEnglish ? 'Fresh' : 'புதியவை',
            icon: Icons.local_florist_rounded,
            color: Colors.pink,
            routeBuilder: () => const VegetableScreen(
                category: 'flower',
                title: 'பூக்கள்',
                titleEn: 'Flowers',
                color: Colors.pink),
            img: '🌸'),
        CatData(
            title: state.isEnglish ? 'Chicken' : 'கோழி',
            subtitle: state.isEnglish ? 'Fresh' : 'புதியவை',
            icon: Icons.bakery_dining_rounded,
            color: Colors.redAccent,
            routeBuilder: () => const VegetableScreen(
                category: 'chicken',
                title: 'கோழி',
                titleEn: 'Chicken',
                color: Colors.redAccent),
            img: '🍗'),
        CatData(
            title: state.isEnglish ? 'Mutton' : 'ஆடு',
            subtitle: state.isEnglish ? 'Fresh' : 'புதியவை',
            icon: Icons.restaurant_rounded,
            color: Colors.brown,
            routeBuilder: () => const VegetableScreen(
                category: 'mutton',
                title: 'ஆடு',
                titleEn: 'Mutton',
                color: Colors.brown),
            img: '🥩'),
        CatData(
            title: state.isEnglish ? 'Egg' : 'முட்டை',
            subtitle: state.isEnglish ? 'Varieties' : 'வகைகள்',
            icon: Icons.egg_rounded,
            color: AppColors.egg,
            routeBuilder: () => const VegetableScreen(
                category: 'egg',
                title: 'முட்டை',
                titleEn: 'Eggs',
                color: AppColors.egg),
            img: '🥚'),
        CatData(
            title: state.isEnglish ? 'Beef' : 'மாட்டு இறைச்சி',
            subtitle: state.isEnglish ? 'Fresh' : 'புதியவை',
            icon: Icons.bakery_dining_rounded,
            color: Colors.red.shade900,
            routeBuilder: () => const VegetableScreen(
                category: 'beef',
                title: 'மாட்டு இறைச்சி',
                titleEn: 'Beef',
                color: Colors.red),
            img: '🥩'),
        CatData(
            title: state.isEnglish ? 'Pork' : 'பன்றி இறைச்சி',
            subtitle: state.isEnglish ? 'Fresh' : 'புதியவை',
            icon: Icons.bakery_dining_rounded,
            color: Colors.pink.shade900,
            routeBuilder: () => const VegetableScreen(
                category: 'pork',
                title: 'பன்றி இறைச்சி',
                titleEn: 'Pork',
                color: Colors.pink),
            img: '🥓'),
        CatData(
            title: state.isEnglish ? 'Gold' : 'தங்கம்',
            subtitle: state.isEnglish ? 'Rates' : 'விலை',
            icon: Icons.diamond_rounded,
            color: AppColors.gold,
            routeBuilder: () => const VegetableScreen(
                category: 'gold',
                title: 'தங்கம்',
                titleEn: 'Gold Rates',
                color: AppColors.gold),
            img: '🪙'),
        CatData(
            title: state.isEnglish ? 'Silver' : 'வெள்ளி',
            subtitle: state.isEnglish ? 'Rates' : 'விலை',
            icon: Icons.monetization_on_rounded,
            color: Colors.grey,
            routeBuilder: () => const VegetableScreen(
                category: 'silver',
                title: 'வெள்ளி',
                titleEn: 'Silver',
                color: Colors.grey),
            img: '🥈'),
        CatData(
            title: state.isEnglish ? 'Platinum' : 'பிளாட்டினம்',
            subtitle: state.isEnglish ? 'Rates' : 'விலை',
            icon: Icons.brightness_high_rounded,
            color: Colors.blueGrey.shade200,
            routeBuilder: () => const VegetableScreen(
                category: 'platinum',
                title: 'பிளாட்டினம்',
                titleEn: 'Platinum',
                color: Colors.cyan),
            img: '💎'),
        CatData(
            title: state.isEnglish ? 'Petrol' : 'பெட்ரோல்',
            subtitle: state.isEnglish ? 'Fuel' : 'எரிபொருள்',
            icon: Icons.local_gas_station_rounded,
            color: AppColors.fuel,
            routeBuilder: () => const FuelScreen(),
            img: '⛽'),
        CatData(
            title: state.isEnglish ? 'Diesel' : 'டீசல்',
            subtitle: state.isEnglish ? 'Fuel' : 'எரிபொருள்',
            icon: Icons.commute_rounded,
            color: Colors.blueGrey,
            routeBuilder: () => const FuelScreen(),
            img: '🚜'),
        CatData(
            title: state.isEnglish ? 'LPG' : 'எரிவாயு',
            subtitle: state.isEnglish ? 'Gas' : 'வாயு',
            icon: Icons.propane_tank_rounded,
            color: Colors.deepOrange,
            routeBuilder: () => const VegetableScreen(
                category: 'lpg',
                title: 'எரிவாயு',
                titleEn: 'LPG',
                color: Colors.deepOrange),
            img: '🔥'),
        CatData(
            title: state.isEnglish ? 'Auto Gas' : 'ஆட்டோ கேஸ்',
            subtitle: state.isEnglish ? 'Gas' : 'வாயு',
            icon: Icons.minor_crash_rounded,
            color: Colors.orange,
            routeBuilder: () => const VegetableScreen(
                category: 'autogas',
                title: 'ஆட்டோ கேஸ்',
                titleEn: 'Auto Gas',
                color: Colors.orange),
            img: '💨'),
      ];

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemCount: categories.length,
        itemBuilder: (context, i) {
          final cat = categories[i];
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => cat.routeBuilder()));
            },
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.cardBorder, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(cat.img, style: const TextStyle(fontSize: 28)),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  cat.title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                Text(
                  cat.subtitle,
                  style: TextStyle(
                    fontSize: 9,
                    color: cat.color,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}