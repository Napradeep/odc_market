import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../widgets/price_tile.dart';
import '../../widgets/shimmer_loader.dart';
import '../../widgets/bottom_ad_banner.dart';
import '../blocs/market/market_bloc.dart';
import '../blocs/market/market_event.dart';
import '../blocs/market/market_state.dart';

class VegetableScreen extends StatefulWidget {
  const VegetableScreen({super.key});

  @override
  State<VegetableScreen> createState() => _VegetableScreenState();
}

class _VegetableScreenState extends State<VegetableScreen> {
  String _searchQuery = '';

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
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
            onPressed: () {
              context.read<MarketBloc>().add(LoadMarketData());
            },
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
              onChanged: (val) {
                setState(() {
                  _searchQuery = val.toLowerCase();
                });
              },
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
            child: BlocBuilder<MarketBloc, MarketState>(
              builder: (context, state) {
                if (state is MarketLoading || state is MarketInitial) {
                  return const ShimmerLoader(itemCount: 8);
                }
                if (state is MarketError) {
                  return _buildError();
                }
                if (state is MarketLoaded) {
                  final allVegs = state.topVegetables; // Note: For production, load full list
                  final list = allVegs.where((v) {
                    return v.tamilName.toLowerCase().contains(_searchQuery) ||
                        v.englishName.toLowerCase().contains(_searchQuery);
                  }).toList();

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
                }
                return const SizedBox.shrink();
              },
            ),
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
            onPressed: () {
              context.read<MarketBloc>().add(LoadMarketData());
            },
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
