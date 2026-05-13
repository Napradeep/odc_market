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
  final String category;
  final String title;
  final String titleEn;
  final Color color;

  const VegetableScreen({
    super.key,
    required this.category,
    required this.title,
    required this.titleEn,
    required this.color,
  });

  @override
  State<VegetableScreen> createState() => _VegetableScreenState();
}

class _VegetableScreenState extends State<VegetableScreen> {
  String _searchQuery = '';

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
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  widget.color,
                  widget.color.withValues(alpha: 0.8),
                ],
              ),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withValues(alpha: 0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
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
                            widget.title,
                            style: TextStyle(
                              fontSize: isTablet ? 24 : 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            widget.titleEn,
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
                const SizedBox(height: 20),
                // Search bar inside AppBar area for better "vibe"
                Center(
                  child: Container(
                    width: isTablet ? 500 : double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                    ),
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val.toLowerCase();
                        });
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'தேடு / Search...',
                        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                        border: InputBorder.none,
                        icon: const Icon(Icons.search_rounded, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
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
                  final allItems = state.allData[widget.category] ?? [];
                  final list = allItems.where((v) {
                    return v.tamilName.toLowerCase().contains(_searchQuery) ||
                        v.englishName.toLowerCase().contains(_searchQuery);
                  }).toList();

                  if (list.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off_rounded, size: 64, color: AppColors.textMuted.withValues(alpha: 0.3)),
                          const SizedBox(height: 16),
                          const Text(AppStrings.noData,
                              style: TextStyle(color: AppColors.textMuted, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    );
                  }
                  
                  return ListView.separated(
                    padding: EdgeInsets.fromLTRB(
                      isTablet ? 32 : 16, 
                      20, 
                      isTablet ? 32 : 16, 
                      24
                    ),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      final v = list[i];
                      
                      // Bullion specific layout
                      if (['gold', 'silver', 'platinum'].contains(widget.category)) {
                        return GoldPriceTile(
                          tamilName: v.tamilName,
                          englishName: v.englishName,
                          price: v.todayPrice,
                          yesterdayPrice: v.yesterdayPrice,
                          unit: v.unit,
                        );
                      }

                      return PriceTile(
                        tamilName: v.tamilName,
                        englishName: v.englishName,
                        todayPrice: v.todayPrice,
                        yesterdayPrice: v.yesterdayPrice,
                        unit: v.unit,
                        accentColor: widget.color,
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
              backgroundColor: widget.color,
              foregroundColor: Colors.white,
            ),
            child: const Text(AppStrings.retry),
          ),
        ],
      ),
    );
  }
}
