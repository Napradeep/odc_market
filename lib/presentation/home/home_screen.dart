import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc_market_place/presentation/blocs/location/location_bloc.dart';
import 'package:odc_market_place/presentation/blocs/location/location_state.dart';
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return BlocListener<LocationBloc, LocationState>(
      listenWhen: (prev, curr) => 
          curr is LocationLoaded && (prev is! LocationLoaded || prev.marketCity != curr.marketCity),
      listener: (context, state) {
        if (state is LocationLoaded) {
          context.read<MarketBloc>().add(LoadMarketData(city: state.marketCity));
        }
      },
      child: Scaffold(
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
      ),
    );
  }

  Future<void> _refresh(BuildContext context) async {
    final locState = context.read<LocationBloc>().state;
    String? city;
    if (locState is LocationLoaded) city = locState.marketCity;
    context.read<MarketBloc>().add(LoadMarketData(city: city));
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
          return LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
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
            },
          );
        } else if (state is MarketLoaded) {
          final items = <GridPriceData>[];

          // Helper to add items from a category
          void addFromCat(String cat, String label, String emoji, {int limit = 1}) {
            final list = state.allData[cat] ?? [];
            for (var i = 0; i < list.length && i < limit; i++) {
              final item = list[i];
              items.add(GridPriceData(
                item.englishName, label, item.todayPrice,
                item.priceDiff, item.unit, emoji
              ));
            }
          }

          // Metals
          addFromCat('gold', 'Gold', '🪙', limit: 2);
          addFromCat('silver', 'Silver', '🥈');
          addFromCat('platinum', 'Platina', '💎');
          
          // Fuel
          addFromCat('petrol', 'Petrol', '⛽');
          addFromCat('diesel', 'Diesel', '🚜');
          addFromCat('lpg', 'LPG', '🔥');
          addFromCat('autogas', 'Auto Gas', '💨');

          // Meat & Poultry
          if (state.eggModel != null) {
             items.add(GridPriceData('Egg', 'Poultry', state.eggModel!.pricePerEgg, 
                 state.eggModel!.pricePerEgg - state.eggModel!.yesterdayPerEgg, 'pc', '🥚'));
          }
          addFromCat('chicken', 'Chicken', '🍗');
          addFromCat('mutton', 'Mutton', '🥩');
          addFromCat('fish', 'Fish', '🐟');
          addFromCat('pork', 'Pork', '🥓');
          addFromCat('beef', 'Beef', '🍔');

          // Produce
          addFromCat('vegetable', 'Veg', '🍅', limit: 2);
          addFromCat('fruit', 'Fruit', '🍎', limit: 2);
          addFromCat('flower', 'Flower', '🌸', limit: 2);

          if (items.isEmpty) {
            return const Center(
                child: Text('No data available',
                    style: TextStyle(color: AppColors.textMuted)));
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 900 
                  ? 4 
                  : (constraints.maxWidth > 600 ? 3 : 2);
              
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: items.length,
                itemBuilder: (_, i) => LivePriceCard(data: items[i]),
              );
            },
          );
        }
        return const Center(
            child: Text('Failed to load prices',
                style: TextStyle(color: Colors.red)));
      },
    );
  }
}
