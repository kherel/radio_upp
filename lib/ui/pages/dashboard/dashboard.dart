import 'dart:async';

import 'package:auto_animated/auto_animated.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_listview/infinite_listview.dart';
import 'package:radio_upp/config/brand_colors.dart';
import 'package:radio_upp/config/theme_typo.dart';
import 'package:radio_upp/logic/cubits/local_stations/local_stations_cubit.dart';
import 'package:radio_upp/logic/cubits/search/search_cubit.dart';
import 'package:radio_upp/logic/models/country.dart';
import 'package:radio_upp/logic/models/genre.dart';
import 'package:radio_upp/logic/models/station.dart';
import 'package:radio_upp/ui/components/brand_loader/brand_loader.dart';
import 'package:radio_upp/ui/components/brand_titles/brand_titles.dart';
import 'package:radio_upp/ui/components/genre_label/genre_label.dart';
import 'package:radio_upp/ui/components/header/header.dart';
import 'package:radio_upp/ui/components/side_modal/side_modal.dart';
import 'package:shimmer/shimmer.dart';

part 'genres.dart';
part 'local.dart';
part 'favorites.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final scrollController = ScrollController();
  Duration animationDuration = const Duration(milliseconds: 250);
  Timer? timer;
  @override
  void initState() {
    timer = Timer(const Duration(seconds: 3), _changeList);
    super.initState();
  }

  void _changeList() {
    setState(() {
      animationDuration = Duration.zero;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<SearchCubit>();

    return BlocListener<SearchCubit, SearchState>(
      listener: (context, state) {
        if (state is StationsLoaded) {
          var title = state.genre?.name ?? state.country?.title;

          BrandModal.openModal(
            state.stations,
            title: title!,
          );
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: Header(MediaQuery.of(context)),
            ),
            LiveSliverList(
              visibleFraction: .1,
              controller: scrollController,
              showItemDuration: animationDuration,
              showItemInterval: animationDuration,
              itemCount: 5,
              itemBuilder: buildAnimatedItem,
            ),
            _bouldCountryList(cubit)
          ],
        ),
      ),
    );
  }

  SliverList _bouldCountryList(SearchCubit cubit) {
    var state = cubit.state;

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          ...Country.values.map((c) {
            var isLoading = state is StationsLoading && state.country == c;
            var child = Text(
              c.title,
              style: ThemeTypo.h2,
            );
            return GestureDetector(
              onTap: () {
                cubit.search(country: c);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  width: 56,
                  padding: const EdgeInsets.only(bottom: 2),
                  alignment: Alignment.center,
                  child: isLoading
                      ? Shimmer.fromColors(
                          baseColor: BrandColors.white,
                          highlightColor: BrandColors.darkGreen,
                          child: child,
                        )
                      : child,
                ),
              ),
            );
          }),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom + 10,
          )
        ],
      ),
    );
  }

  Widget buildAnimatedItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) {
    return FadeTransition(
      opacity: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(animation),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -0.1),
          end: Offset.zero,
        ).animate(animation),
        child: [
          const _Favorites(),
          const _GenresBlock(),
          const _Local(),
          const SizedBox(height: 30),
          const BrandTitle(text: 'Country'),
        ][index],
      ),
    );
  }
}
