import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../widgets/price_tile.dart';
import '../../widgets/shimmer_loader.dart';
import '../../widgets/bottom_ad_banner.dart';
import 'fuel_binding.dart';

class FuelScreen extends GetView<FuelController> {
  const FuelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.fuel,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.fuel,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text(AppStrings.fuelEn,
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
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                ShimmerCard(height: 110),
                SizedBox(height: 14),
                ShimmerCard(height: 110),
              ],
            ),
          );
        }

        final fuel = controller.fuel.value;
        if (fuel == null) {
          return const Center(
            child: Text(AppStrings.noData,
                style: TextStyle(color: AppColors.textMuted)),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Banner
              _buildBanner(),
              const SizedBox(height: 20),

              // Petrol card
              FuelPriceTile(
                tamilName: AppStrings.petrol,
                englishName: AppStrings.petrolEn,
                price: fuel.petrolPrice,
                yesterdayPrice: fuel.yesterdayPetrol,
                accentColor: AppColors.priceDown,
                icon: Icons.local_gas_station_rounded,
              ),
              const SizedBox(height: 14),

              // Diesel card
              FuelPriceTile(
                tamilName: AppStrings.diesel,
                englishName: AppStrings.dieselEn,
                price: fuel.dieselPrice,
                yesterdayPrice: fuel.yesterdayDiesel,
                accentColor: AppColors.fuelLight,
                icon: Icons.oil_barrel_rounded,
              ),
              const SizedBox(height: 20),

              if (fuel.updatedAt != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.update_rounded,
                        size: 14, color: AppColors.textMuted),
                    const SizedBox(width: 6),
                    Text(
                      'புதுப்பிக்கப்பட்டது: ${fuel.updatedAt!.day}/${fuel.updatedAt!.month}/${fuel.updatedAt!.year}',
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

  Widget _buildBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.fuelLight.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.fuelLight.withValues(alpha: 0.25)),
      ),
      child: const Row(
        children: [
          Text('⛽', style: TextStyle(fontSize: 28)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'ஒட்டன்சத்திரம் — தினசரி எரிபொருள் விலை\nOddanchatram Daily Fuel Rates',
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
