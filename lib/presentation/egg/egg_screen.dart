import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../widgets/shimmer_loader.dart';
import '../../widgets/price_indicator.dart';
import '../../widgets/bottom_ad_banner.dart';
import 'egg_binding.dart';

class EggScreen extends GetView<EggController> {
  const EggScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.egg,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.eggs,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text(AppStrings.eggsEn,
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
                        padding: EdgeInsets.only(bottom: 12),
                        child: ShimmerCard(height: 100),
                      )),
            ),
          );
        }

        final egg = controller.egg.value;
        if (egg == null) {
          return const Center(
            child: Text(AppStrings.noData,
                style: TextStyle(color: AppColors.textMuted)),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Hero card
              _EggHeroCard(
                price: egg.pricePerEgg,
                yesterday: egg.yesterdayPerEgg,
                diff: egg.priceDiff,
              ),
              const SizedBox(height: 16),

              // Bulk pricing
              _buildBulkCard(
                  '30 முட்டை தட்டு', AppStrings.trayOf30En, egg.pricePerTray),
              const SizedBox(height: 12),
              _buildBulkCard(AppStrings.hundredEggs, AppStrings.hundredEggsEn,
                  egg.pricePer100),
              const SizedBox(height: 20),

              // Updated time
              if (egg.updatedAt != null) _buildUpdatedTime(egg.updatedAt!),
            ],
          ),
        );
      }),
      bottomNavigationBar: const BottomAdBanner(),
    );
  }

  Widget _buildBulkCard(String tamil, String english, double price) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.eggLight.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Text('🥚', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tamil,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    )),
                Text(english,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textMuted)),
              ],
            ),
          ),
          Text(
            '${AppConstants.currency}${price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdatedTime(DateTime dt) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.update_rounded, size: 14, color: AppColors.textMuted),
        const SizedBox(width: 6),
        Text(
          'புதுப்பிக்கப்பட்டது: ${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}',
          style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
        ),
      ],
    );
  }
}

class _EggHeroCard extends StatelessWidget {
  final double price;
  final double yesterday;
  final double diff;
  const _EggHeroCard({
    required this.price,
    required this.yesterday,
    required this.diff,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.eggLight.withValues(alpha: 0.3),
            AppColors.surfaceLight,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.eggLight.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          const Text('🥚', style: TextStyle(fontSize: 52)),
          const SizedBox(height: 12),
          const Text(
            AppStrings.eggs,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const Text(
            AppStrings.eggsEn,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '${AppConstants.currency}${price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const Text(
            AppStrings.perEggsEn,
            style: TextStyle(fontSize: 13, color: AppColors.textMuted),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'நேற்று: ${AppConstants.currency}${yesterday.toStringAsFixed(2)}  ',
                style:
                    const TextStyle(fontSize: 13, color: AppColors.textMuted),
              ),
              PriceIndicator(diff: diff),
            ],
          ),
        ],
      ),
    );
  }
}
