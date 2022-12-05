import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:radio_upp/config/brand_colors.dart';
import 'package:radio_upp/config/get_it_config.dart';
import 'package:radio_upp/config/theme_typo.dart';
import 'package:radio_upp/logic/cubits/radio_cubit/current_station_cubit.dart';
import 'package:radio_upp/logic/get_it/navigator.dart';
import 'package:radio_upp/logic/models/country.dart';
import 'package:radio_upp/logic/models/station.dart';
import 'package:radio_upp/ui/components/brand_icons/brand_icons.dart';
import 'package:radio_upp/ui/components/genre_label/genre_label.dart';
import 'package:radio_upp/ui/components/play_button/play_button.dart';

import '../brand_loader/brand_loader.dart';

class BrandModal {
  static Future<T?> openModal<T>(List<Station> list, {required String title}) {
    return showDialog<T>(
      context: getIt<NavigationService>().navigator.overlay!.context,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: true,
      builder: (context) => SelectStations(
        list: list,
        title: title,
      ),
      useSafeArea: false,
    );
  }
}

class SelectStations extends StatefulWidget {
  const SelectStations({
    super.key,
    required this.list,
    required this.title,
  });

  final List<Station> list;
  final String title;

  @override
  State<SelectStations> createState() => _SelectStationsState();
}

class _SelectStationsState extends State<SelectStations>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Animation<Offset>? translateAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  void _afterLayout(_) {
    translateAnimation = Tween<Offset>(
      begin: Offset(MediaQuery.of(context).size.width - 80, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOutCirc,
    ));

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Material(
        color: BrandColors.darkBlue.withOpacity(0.8),
        child: SafeArea(
          bottom: false,
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Column(
                children: [
                  const SizedBox(height: 30),
                  Opacity(
                    opacity: controller.value,
                    child: Row(
                      children: [
                        const SizedBox(width: 30),
                        Text(
                          widget.title,
                          style: ThemeTypo.h2,
                        ),
                        const Spacer(),
                        const Icon(
                          BrandIcons.close,
                          size: 25,
                        ),
                        const SizedBox(width: 30)
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Transform.translate(
                      offset: translateAnimation?.value ?? const Offset(-2, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(width: 20),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomScrollView(
                                slivers: [
                                  const SliverToBoxAdapter(
                                    child: SizedBox(height: 10),
                                  ),
                                  ...widget.list
                                      .map((e) => _StationCard(
                                            key: ValueKey(e.id),
                                            station: e,
                                          ))
                                      .toList(),
                                  SliverToBoxAdapter(
                                    child: SizedBox(
                                      height: MediaQuery.of(context)
                                              .padding
                                              .bottom +
                                          10,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _StationCard extends StatelessWidget {
  const _StationCard({
    Key? key,
    required this.station,
  }) : super(key: key);

  final Station station;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: false,
      delegate: _StationCardDelegate(
        station: station,
      ),
    );
  }
}

class _StationCardDelegate extends SliverPersistentHeaderDelegate {
  _StationCardDelegate({
    required this.station,
  });

  Station station;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var leftSize = maxExtent - shrinkOffset;
    var v = leftSize.clamp(0, 110) / 110;

    var child = Opacity(
      opacity: CurveTween(curve: Curves.easeIn).transform(v),
      child: Transform.translate(
        offset: Offset(shrinkOffset / 1.2, 0),
        child: SingleChildScrollView(
          child: InnerCard(
            station: station,
          ),
        ),
      ),
    );

    return child;
  }

  @override
  double get maxExtent => 120;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class InnerCard extends StatelessWidget {
  const InnerCard({
    super.key,
    required this.station,
  });

  final Station station;

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<RadioCubit>();
    var status = cubit.state.checkButtonState(station);
    return GestureDetector(
      onTap: cubit.getActionByStatus(status, station),
      child: ClipRRect(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(
            status == StationStatus.error ? 31 : 30,
          ),
        ),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            status == StationStatus.error
                ? Colors.black.withOpacity(0.3)
                : Colors.transparent,
            BlendMode.darken,
          ),
          child: Container(
            height: 110,
            padding: const EdgeInsets.fromLTRB(0.5, 0.5, 0, 0.5),
            decoration: BoxDecoration(
              gradient: BrandColors.greyGradient,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(30),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                gradient: BrandColors.blueGradient,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(30),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(21),
                    child: CachedNetworkImage(
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      imageUrl:
                          'https://www.radioair.info/images_radios/${station.logoUrl}',
                      placeholder: (context, url) => const BrandLoader(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          station.country?.title ?? '',
                          style: ThemeTypo.h5,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                        const Spacer(),
                        Text(
                          station.name,
                          style: ThemeTypo.basis,
                          maxLines: 2,
                        ),
                        const Spacer(),
                        if (station.genre != null)
                          GenreLabel(genre: station.genre!),
                      ],
                    ),
                  ),
                  PlayButton(status: status),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
