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

class FuelScreen extends StatelessWidget {
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
            return const ShimmerLoader(itemCount: 2);
          }
          if (state is MarketError) {
            return Center(
              child: Text(state.message, style: const TextStyle(color: Colors.red)),
            );
          }
          if (state is MarketLoaded) {
            final fuel = state.fuelModel;
            if (fuel == null) {
              return const Center(
                child: Text(AppStrings.noData,
                    style: TextStyle(color: AppColors.textMuted)),
              );
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                PriceTile(
                  tamilName: 'பெட்ரோல்',
                  englishName: 'Petrol',
                  todayPrice: fuel.petrolPrice,
                  yesterdayPrice: fuel.yesterdayPetrol,
                  unit: 'L',
                  accentColor: AppColors.fuelLight,
                ),
                const SizedBox(height: 12),
                PriceTile(
                  tamilName: 'டீசல்',
                  englishName: 'Diesel',
                  todayPrice: fuel.dieselPrice,
                  yesterdayPrice: fuel.yesterdayDiesel,
                  unit: 'L',
                  accentColor: AppColors.fuelLight,
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
