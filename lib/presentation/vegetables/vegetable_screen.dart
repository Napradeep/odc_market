import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../widgets/price_tile.dart';
import '../../widgets/shimmer_loader.dart';
import '../../widgets/bottom_ad_banner.dart';
import 'vegetable_controller.dart';

class VegetableScreen extends GetView<VegetableController> {
  const VegetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.vegetable,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.vegetables,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text(AppStrings.vegetablesEn,
                style: TextStyle(
                    fontSize: 11, color: Colors.white70)),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
            onPressed: controller.onInit,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: TextField(
              onChanged: controller.search,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: const InputDecoration(
                hintText: 'தேடு / Search...',
                hintStyle: TextStyle(color: AppColors.textMuted),
                border: InputBorder.none,
                icon: Icon(Icons.search_rounded, color: AppColors.textMuted),
              ),
            ),
          ),

          // List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const ShimmerLoader(itemCount: 8);
              }
              if (controller.error.isNotEmpty) {
                return _buildError();
              }
              final list = controller.filtered;
              if (list.isEmpty) {
                return const Center(
                  child: Text(AppStrings.noData,
                      style: TextStyle(color: AppColors.textMuted)),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                itemCount: list.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) {
                  final v = list[i];
                  return PriceTile(
                    tamilName: v.tamilName,
                    englishName: v.englishName,
                    todayPrice: v.todayPrice,
                    yesterdayPrice: v.yesterdayPrice,
                    unit: v.unit,
                    accentColor: AppColors.vegetableLight,
                  );
                },
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: const BottomAdBanner(),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off_rounded,
              size: 48, color: AppColors.textMuted),
          const SizedBox(height: 12),
          const Text(AppStrings.error,
              style: TextStyle(color: AppColors.textMuted)),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: controller.onInit,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.vegetable,
              foregroundColor: Colors.white,
            ),
            child: const Text(AppStrings.retry),
          ),
        ],
      ),
    );
  }
}
