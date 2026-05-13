import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../blocs/location/location_bloc.dart';
import '../../blocs/location/location_event.dart';
import '../../blocs/location/location_state.dart';
import '../../blocs/language/language_bloc.dart';
import '../../blocs/language/language_event.dart';
import '../../blocs/language/language_state.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 110,
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: AppColors.background.withValues(alpha: 0.95),
      flexibleSpace: FlexibleSpaceBar(
        background: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
      ),
      title: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          return BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, langState) {
              String areaName = langState.isEnglish ? 'Searching...' : 'தேடுகிறது...';
              String district = '';

              if (state is LocationLoaded) {
                areaName = state.location.area;
                district = state.location.district;
              } else if (state is LocationError) {
                areaName = langState.isEnglish ? 'Location Denied' : 'அனுமதி மறுக்கப்பட்டது';
                district = '';
              } else if (state is LocationLoading) {
                areaName = langState.isEnglish ? 'Locating...' : 'கண்டறியப்படுகிறது...';
                district = '';
              } else if (state is LocationInitial) {
                areaName = langState.isEnglish ? 'Searching...' : 'தேடுகிறது...';
                district = '';
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.near_me_rounded,
                          color: AppColors.accent, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        langState.isEnglish ? 'Your Location' : 'உங்கள் இருப்பிடம்',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary.withValues(alpha: 0.8),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () => context.read<LocationBloc>().add(LoadLocation()),
                    child: Text(
                      district.isEmpty ? areaName : '$areaName, $district',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      actions: [
        BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            return TextButton(
              onPressed: () => context.read<LanguageBloc>().add(ToggleLanguage()),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                ),
                child: Text(
                  state.isEnglish ? 'தமிழ்' : 'English',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.surfaceLight,
            radius: 20,
            child: IconButton(
              icon: const Icon(Icons.person_rounded,
                  color: AppColors.textPrimary, size: 20),
              onPressed: () {},
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: AppColors.cardBorder.withValues(alpha: 0.5),
          height: 1.0,
        ),
      ),
    );
  }
}
