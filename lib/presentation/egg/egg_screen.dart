import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../widgets/bottom_ad_banner.dart';
import '../../widgets/price_tile.dart';
import '../../widgets/shimmer_loader.dart';
import '../blocs/market/market_bloc.dart';
import '../blocs/market/market_event.dart';
import '../blocs/market/market_state.dart';

class EggScreen extends StatelessWidget {
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
            onPressed: () => context.read<MarketBloc>().add(LoadMarketData()),
          ),
        ],
      ),
      body: BlocBuilder<MarketBloc, MarketState>(
        builder: (context, state) {
          if (state is MarketLoading || state is MarketInitial) {
            return const ShimmerLoader(itemCount: 3);
          }
          if (state is MarketError) {
            return Center(
              child: Text(state.message, style: const TextStyle(color: Colors.red)),
            );
          }
          if (state is MarketLoaded) {
            final egg = state.eggModel;
            if (egg == null) {
              return const Center(
                child: Text(AppStrings.noData,
                    style: TextStyle(color: AppColors.textMuted)),
              );
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                PriceTile(
                  tamilName: 'ஒரு முட்டை',
                  englishName: 'Per Egg',
                  todayPrice: egg.pricePerEgg,
                  yesterdayPrice: egg.yesterdayPerEgg,
                  accentColor: AppColors.eggLight,
                ),
                const SizedBox(height: 12),
                PriceTile(
                  tamilName: 'ஒரு ட்ரே (30)',
                  englishName: '1 Tray',
                  todayPrice: egg.pricePerTray,
                  yesterdayPrice: egg.yesterdayPerEgg * 30,
                  accentColor: AppColors.eggLight,
                ),
                const SizedBox(height: 12),
                PriceTile(
                  tamilName: '100 முட்டை',
                  englishName: '100 Eggs',
                  todayPrice: egg.pricePer100,
                  yesterdayPrice: egg.yesterdayPerEgg * 100,
                  accentColor: AppColors.eggLight,
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: const BottomAdBanner(),
    );
  }
}
