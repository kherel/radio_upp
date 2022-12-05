import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_upp/logic/models/station.dart';
import 'package:audio_session/audio_session.dart';

part 'current_station_state.dart';

class RadioCubit extends Cubit<RadioCubitState> {
  RadioCubit() : super(const RadioCubitStopped(badStationIds: [])) {
    init();
    playerStateStream =
        player.playerStateStream.asBroadcastStream().listen(listener);
  }

  final player = AudioPlayer();
  StreamSubscription<PlayerState>? playerStateStream;

  void listener(PlayerState event) {
    var isReady = event.processingState == ProcessingState.ready;
    var isWaitingToPlay = state is RadioCubitWaiting;

    if (isReady && isWaitingToPlay) {
      player.play();
      emit(
        RadioCubitPlaying(
          station: (state as RadioCubitWaiting).station,
          badStationIds: state.badStationIds,
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    super.close();
    player.dispose();
    playerStateStream?.cancel();
  }

  VoidCallback? getActionByStatus(StationStatus status, Station station) {
    switch (status) {
      case StationStatus.canPlay:
        return () => play(station);
      case StationStatus.canPause:
        return pause;
      case StationStatus.error:
        return null;
    }
  }

  Future<void> init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
  }

  void pause() async {
    assert(state is RadioCubitStateWithStation);
    if (player.playing) {
      await player.pause();
    }
    emit(
      RadioCubitPaused(
        station: (state as RadioCubitStateWithStation).station,
        badStationIds: state.badStationIds,
      ),
    );
  }

  void play(Station station) async {
    print('click on ${station.id}');
    var isStoped = state is RadioCubitStopped;
    var isNewStation = (state is RadioCubitStateWithStation) &&
        (state as RadioCubitStateWithStation).station != station;

    if (isStoped || isNewStation) {
      emit(RadioCubitWaiting(
        station: station,
        badStationIds: state.badStationIds,
      ));

      if (player.playing) {
        await player.stop();
      }

      try {
        var audioSourse = AudioSource.uri(Uri.parse(station.streamURl));
// player player

        await player.setAudioSource(audioSourse);
      } catch (e) {
        print(station.id);
        emit(
          RadioCubitStopped(
            badStationIds: [...state.badStationIds, station.id],
          ),
        );
      }
    } else if (state is RadioCubitPaused) {
      emit(RadioCubitPlaying(
        station: (state as RadioCubitPaused).station,
        badStationIds: state.badStationIds,
      ));

      await player.play();
    }
  }
}
