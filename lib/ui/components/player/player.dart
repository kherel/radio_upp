import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_upp/config/brand_colors.dart';
import 'package:radio_upp/config/theme_typo.dart';
import 'package:radio_upp/logic/cubits/radio_cubit/current_station_cubit.dart';
import 'package:radio_upp/logic/models/country.dart';
import 'package:radio_upp/ui/components/genre_label/genre_label.dart';
import 'package:radio_upp/ui/components/play_button/play_button.dart';
import 'package:radio_upp/ui/components/radio_avatar/radio_avatar.dart';

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<RadioCubit>();
    var state = cubit.state;

    var isHidden = state is RadioCubitStopped;
    Widget? widget;
    if (state is RadioCubitStateWithStation) {
      var status = state.checkButtonState(state.station);
      widget = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RadioAvatar.s50(state.station.logoUrl),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              Text(
                state.station.name,
                style: ThemeTypo.small,
                textAlign: TextAlign.center,
              ),
              Container(
                height: 30,
                alignment: Alignment.center,
                child: _AnimatedDetails(
                  children: [
                    Text(
                      state.station.country?.title ?? '',
                      style: ThemeTypo.superSmall,
                    ),
                    if (state.station.genre != null)
                      GenreLabel(genre: state.station.genre!)
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: cubit.getActionByStatus(status, state.station),
            child: PlayButton(
              status: status,
            ),
          )
        ],
      );
    }
    return AnimatedSlide(
      offset: isHidden ? const Offset(0, 100) : Offset.zero,
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
      child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          height: MediaQuery.of(context).padding.bottom + 70,
          decoration: const BoxDecoration(
            gradient: BrandColors.blackGradient,
            border: Border(
              top: BorderSide(
                color: BrandColors.lightGrey,
                width: 0.5,
              ),
            ),
          ),
          child: widget),
    );
  }
}

class _AnimatedDetails extends StatefulWidget {
  const _AnimatedDetails({required this.children});

  final List<StatelessWidget> children;
  @override
  State<_AnimatedDetails> createState() => _AnimatedDetailsState();
}

class _AnimatedDetailsState extends State<_AnimatedDetails> {
  late Timer timer;
  var activeIndex = 0;
  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(seconds: 4),
      (_) {
        var maxIndex = widget.children.length - 1;
        setState(() {
          activeIndex = activeIndex == maxIndex ? 0 : activeIndex + 1;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: widget.children[activeIndex],
    );
  }
}
