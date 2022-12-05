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
    return BlocListener<SearchCubit, SearchState>(
      listener: (context, state) {
        if (state is StationsLoaded) {
          if (state.stations.isEmpty) {
            print(state.genre);
            print(state.country);
          } else {
            BrandModal.openModal(state.stations);
          }
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
            _bouldCountryList()
          ],
        ),
      ),
    );
  }

  SliverList _bouldCountryList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        Country.values
            .map((e) => GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 56,
                          padding: const EdgeInsets.only(bottom: 2),
                          alignment: Alignment.centerRight,
                          child: const Text(
                            '33',
                            style: ThemeTypo.regular,
                          ),
                        ),
                        const SizedBox(width: 11),
                        Text(
                          e.title,
                          style: ThemeTypo.h2,
                        ),
                      ],
                    ),
                  ),
                ))
            .toList(),
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
      // And slide transition
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -0.1),
          end: Offset.zero,
        ).animate(animation),
        // Paste you Widget
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
  // For example wrap with fade transition

}
