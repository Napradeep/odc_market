import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../app/routes/app_routes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../widgets/bottom_ad_banner.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        color: AppColors.accent,
        backgroundColor: AppColors.surfaceLight,
        onRefresh: controller.refresh,
        child: CustomScrollView(
          slivers: [
            _buildAppBar(),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 8),
                  _buildDateBar(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('விலை பட்டியல்', 'Price Categories'),
                  const SizedBox(height: 16),
                  _buildCategoryGrid(),
                  const SizedBox(height: 28),
                  _buildQuickSummary(),
                  const SizedBox(height: 20),
                  _buildInfoBanner(),
                ]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAdBanner(),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 180,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.primaryDark,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        AppStrings.appNameEn,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryDark, Color(0xFF1B5E20)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.storefront_rounded,
                        color: AppColors.accent, size: 28),
                  ),
                  const SizedBox(width: 14),
                  // App Titles
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppStrings.appName,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                            height: 1.2,
                          ),
                        ),
                        Text(
                          AppStrings.appNameEn,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Location Tag
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_on_rounded,
                        size: 12, color: AppColors.accent),
                    SizedBox(width: 4),
                    Text(
                      AppStrings.locationEn,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh_rounded, color: AppColors.accent),
          onPressed: controller.refresh,
        ),
      ],
    );
  }

  Widget _buildDateBar() {
    final now = DateTime.now();
    final dayStr = DateFormat('EEEE, dd MMMM yyyy').format(now);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today_rounded,
              size: 16, color: AppColors.accent),
          const SizedBox(width: 10),
          Text(
            dayStr,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Obx(() => controller.lastUpdated.isNotEmpty
              ? Row(
                  children: [
                    const Icon(Icons.update_rounded,
                        size: 14, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text(
                      controller.lastUpdated.value,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String tamil, String english) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          tamil,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '/ $english',
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryGrid() {
    final categories = [
      const _CategoryItem(
        tamilLabel: AppStrings.vegetables,
        englishLabel: AppStrings.vegetablesEn,
        icon: Icons.eco_rounded,
        color: AppColors.vegetableLight,
        route: AppRoutes.vegetables,
        emoji: '🥬',
      ),
      const _CategoryItem(
        tamilLabel: AppStrings.eggs,
        englishLabel: AppStrings.eggsEn,
        icon: Icons.egg_rounded,
        color: AppColors.eggLight,
        route: AppRoutes.egg,
        emoji: '🥚',
      ),
      const _CategoryItem(
        tamilLabel: AppStrings.fuel,
        englishLabel: AppStrings.fuelEn,
        icon: Icons.local_gas_station_rounded,
        color: AppColors.fuelLight,
        route: AppRoutes.fuel,
        emoji: '⛽',
      ),
      const _CategoryItem(
        tamilLabel: AppStrings.gold,
        englishLabel: AppStrings.goldEn,
        icon: Icons.diamond_rounded,
        color: AppColors.goldLight,
        route: AppRoutes.gold,
        emoji: '🪙',
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 1.3,
      ),
      itemCount: categories.length,
      itemBuilder: (_, i) => _CategoryCard(item: categories[i]),
    );
  }

  Widget _buildQuickSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('இன்றைய சில விலைகள்', 'Today\'s Highlights'),
        const SizedBox(height: 12),
        Obx(() {
          if (controller.isLoading.value) {
            return Column(
              children: List.generate(
                3,
                (_) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            );
          }
          if (controller.topVegetables.isEmpty) {
            return const Center(
              child: Text(
                AppStrings.noData,
                style: TextStyle(color: AppColors.textMuted),
              ),
            );
          }
          return Column(
            children: controller.topVegetables
                .map((v) => _QuickPriceRow(
                      tamil: v.tamilName,
                      english: v.englishName,
                      price: v.todayPrice,
                      diff: v.priceDiff,
                    ))
                .toList(),
          );
        }),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.vegetables),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.cardBorder),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'அனைத்து காய்கறி விலைகள் →',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Text('📍', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.location,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Text(
                  AppStrings.district,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryItem {
  final String tamilLabel;
  final String englishLabel;
  final IconData icon;
  final Color color;
  final String route;
  final String emoji;
  const _CategoryItem({
    required this.tamilLabel,
    required this.englishLabel,
    required this.icon,
    required this.color,
    required this.route,
    required this.emoji,
  });
}

class _CategoryCard extends StatelessWidget {
  final _CategoryItem item;
  const _CategoryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(item.route),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              item.color.withValues(alpha: 0.25),
              item.color.withValues(alpha: 0.10),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(color: item.color.withValues(alpha: 0.35), width: 1),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -10,
              bottom: -10,
              child: Text(item.emoji,
                  style: const TextStyle(fontSize: 60, height: 1)),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: item.color.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(item.icon, color: item.color, size: 22),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.tamilLabel,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        item.englishLabel,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickPriceRow extends StatelessWidget {
  final String tamil;
  final String english;
  final double price;
  final double diff;
  const _QuickPriceRow({
    required this.tamil,
    required this.english,
    required this.price,
    required this.diff,
  });

  @override
  Widget build(BuildContext context) {
    final isUp = diff > 0;
    final isDown = diff < 0;
    final indicatorColor = isUp
        ? AppColors.priceUp
        : isDown
            ? AppColors.priceDown
            : AppColors.priceStable;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: indicatorColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '$tamil / $english',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            '${AppConstants.currency}${price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
