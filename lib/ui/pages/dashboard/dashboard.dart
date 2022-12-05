import 'package:auto_animated/auto_animated.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_listview/infinite_listview.dart';
import 'package:radio_upp/config/brand_colors.dart';
import 'package:radio_upp/config/theme_typo.dart';
import 'package:radio_upp/logic/cubits/local_stations/local_stations_cubit.dart';
import 'package:radio_upp/logic/models/genre.dart';
import 'package:radio_upp/logic/models/station.dart';
import 'package:radio_upp/ui/components/brand_loader/brand_loader.dart';
import 'package:radio_upp/ui/components/brand_titles/brand_titles.dart';
import 'package:radio_upp/ui/components/genre_label/genre_label.dart';
import 'package:radio_upp/ui/components/header/header.dart';

part 'genres.dart';
part 'local.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final scrollController = ScrollController();
  final Duration listShowItemDuration = const Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: Header(MediaQuery.of(context)),
          ),
          LiveSliverList(
            controller: scrollController,
            showItemDuration: listShowItemDuration,
            itemCount: 5,
            itemBuilder: buildAnimatedItem,
          ),
        ],
      ),
    );
  }

  Widget buildAnimatedItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) =>
      // For example wrap with fade transition
      FadeTransition(
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
            const BrandTitle(text: 'My favoites'),
            const _GenresBlock(),
            const _Local(),
            const SizedBox(height: 30),
            const BrandTitle(text: 'Country'),
          ][index],
        ),
      );
}
