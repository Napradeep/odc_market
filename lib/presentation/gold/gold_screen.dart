import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../widgets/price_tile.dart';
import '../../widgets/shimmer_loader.dart';
import '../../widgets/bottom_ad_banner.dart';
import 'gold_binding.dart';

class GoldScreen extends GetView<GoldController> {
  const GoldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.gold,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.gold,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text(AppStrings.goldEn,
                style: TextStyle(fontSize: 11, color: Colors.white70)),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: List.generate(
                  3,
                  (_) => const Padding(
                        padding: EdgeInsets.only(bottom: 14),
                        child: ShimmerCard(height: 120),
                      )),
            ),
          );
        }

        final gold = controller.gold.value;
        if (gold == null) {
          return const Center(
            child: Text(AppStrings.noData,
                style: TextStyle(color: AppColors.textMuted)),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildGoldHeader(),
              const SizedBox(height: 20),
              GoldPriceTile(
                tamilName: AppStrings.gold22k,
                englishName: AppStrings.gold22kEn,
                price: gold.gold22k,
                yesterdayPrice: gold.yesterdayGold22k,
                unit: 'gram',
              ),
              const SizedBox(height: 14),
              GoldPriceTile(
                tamilName: AppStrings.gold24k,
                englishName: AppStrings.gold24kEn,
                price: gold.gold24k,
                yesterdayPrice: gold.yesterdayGold24k,
                unit: 'gram',
              ),
              const SizedBox(height: 14),
              GoldPriceTile(
                tamilName: AppStrings.silver,
                englishName: AppStrings.silverEn,
                price: gold.silver,
                yesterdayPrice: gold.yesterdaySilver,
                unit: 'gram',
              ),
              const SizedBox(height: 20),
              if (gold.updatedAt != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.update_rounded,
                        size: 14, color: AppColors.textMuted),
                    const SizedBox(width: 6),
                    Text(
                      'புதுப்பிக்கப்பட்டது: ${gold.updatedAt!.day}/${gold.updatedAt!.month}/${gold.updatedAt!.year}',
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textMuted),
                    ),
                  ],
                ),
            ],
          ),
        );
      }),
      bottomNavigationBar: const BottomAdBanner(),
    );
  }

  Widget _buildGoldHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accentLight.withValues(alpha: 0.15),
            AppColors.surfaceLight,
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border:
            Border.all(color: AppColors.accentLight.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          const Text('🪙', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'ஒட்டன்சத்திரம் — தினசரி தங்க விலை\nOddanchatram Daily Gold Rates',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
