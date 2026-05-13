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
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Premium Custom AppBar
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              bottom: 20,
              left: 8,
              right: 8,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.fuel,
                  Color(0xFF1976D2), // Slightly darker blue
                ],
              ),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.fuel.withValues(alpha: 0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.fuel,
                        style: TextStyle(
                          fontSize: isTablet ? 24 : 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        AppStrings.fuelEn,
                        style: TextStyle(
                          fontSize: isTablet ? 14 : 12,
                          color: Colors.white.withValues(alpha: 0.8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh_rounded, color: Colors.white),
                  onPressed: () {
                    context.read<MarketBloc>().add(LoadMarketData());
                  },
                ),
              ],
            ),
          ),

          // List
          Expanded(
            child: BlocBuilder<MarketBloc, MarketState>(
              builder: (context, state) {
                if (state is MarketLoading || state is MarketInitial) {
                  return const ShimmerLoader(itemCount: 2);
                }
                if (state is MarketError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.wifi_off_rounded, size: 48, color: AppColors.textMuted),
                        const SizedBox(height: 12),
                        Text(state.message, style: const TextStyle(color: AppColors.textMuted)),
                      ],
                    ),
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
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 32 : 16, 
                      vertical: 24
                    ),
                    children: [
                      FuelPriceTile(
                        tamilName: 'பெட்ரோல்',
                        englishName: 'Petrol',
                        price: fuel.petrolPrice,
                        yesterdayPrice: fuel.yesterdayPetrol,
                        accentColor: AppColors.fuel,
                        icon: Icons.local_gas_station_rounded,
                      ),
                      const SizedBox(height: 16),
                      FuelPriceTile(
                        tamilName: 'டீசல்',
                        englishName: 'Diesel',
                        price: fuel.dieselPrice,
                        yesterdayPrice: fuel.yesterdayDiesel,
                        accentColor: Colors.blueGrey,
                        icon: Icons.commute_rounded,
                      ),
                    ],
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
}
