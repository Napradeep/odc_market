import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/bottom_ad_banner.dart';
import '../blocs/market/market_bloc.dart';
import '../blocs/market/market_event.dart';
import '../blocs/market/market_state.dart';
import '../blocs/language/language_bloc.dart';
import '../blocs/language/language_state.dart';
import 'widgets/horizontal_categories.dart';
import 'widgets/live_price_card.dart';
import 'widgets/home_sliver_app_bar.dart';
import 'widgets/home_greeting.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _refresh(BuildContext context) async {
    context.read<MarketBloc>().add(LoadMarketData());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withValues(alpha: 0.1),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                child: Container(),
              ),
            ),
          ),
          RefreshIndicator(
            color: AppColors.accent,
            backgroundColor: AppColors.surfaceLight,
            onRefresh: () => _refresh(context),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                const HomeSliverAppBar(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HomeGreeting(),
                        const SizedBox(height: 24),
                        _buildSectionHeader(context, 'Explore', Icons.explore_rounded),
                        const SizedBox(height: 16),
                        const HorizontalCategories(),
                        const SizedBox(height: 32),
                        _buildSectionHeader(context, 'Live Prices', Icons.insights_rounded),
                        const SizedBox(height: 16),
                        _buildLivePricesGrid(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomAdBanner(),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        String translatedTitle = title;
        if (!state.isEnglish) {
          if (title == 'Explore') translatedTitle = 'ஆராய்க';
          if (title == 'Live Prices') translatedTitle = 'நேரடி விலைகள்';
        }

        return Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(width: 8),
            Text(
              translatedTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                letterSpacing: 0.5,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLivePricesGrid() {
    return BlocBuilder<MarketBloc, MarketState>(
      builder: (context, state) {
        if (state is MarketLoading || state is MarketInitial) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.9,
            ),
            itemCount: 4,
            itemBuilder: (_, __) => Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        } else if (state is MarketLoaded) {
          final items = <GridPriceData>[];

          if (state.topVegetables.isNotEmpty) {
            final veg = state.topVegetables.first;
            items.add(GridPriceData(
                'Tomato', 'Vegetables', veg.todayPrice, veg.priceDiff, 'kg', '🍅'));
            if (state.topVegetables.length > 1) {
              final veg2 = state.topVegetables[1];
              items.add(GridPriceData(veg2.englishName, 'Vegetables',
                  veg2.todayPrice, veg2.priceDiff, 'kg', '🧅'));
            }
          }

          if (state.eggModel != null) {
            items.add(GridPriceData(
                'Egg',
                'Poultry',
                state.eggModel!.pricePerEgg,
                state.eggModel!.pricePerEgg - state.eggModel!.yesterdayPerEgg,
                'pc',
                '🥚'));
          }
          if (state.fuelModel != null) {
            items.add(GridPriceData(
                'Petrol',
                'Fuel',
                state.fuelModel!.petrolPrice,
                state.fuelModel!.petrolPrice - state.fuelModel!.yesterdayPetrol,
                'L',
                '⛽'));
          }

          if (items.isEmpty) {
            return const Center(
                child: Text('No data available',
                    style: TextStyle(color: AppColors.textMuted)));
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: items.length,
            itemBuilder: (_, i) => LivePriceCard(data: items[i]),
          );
        }
        return const Center(
            child: Text('Failed to load prices',
                style: TextStyle(color: Colors.red)));
      },
    );
  }
}
