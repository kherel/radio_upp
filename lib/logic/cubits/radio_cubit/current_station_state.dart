part of 'current_station_cubit.dart';

abstract class RadioCubitState extends Equatable {
  const RadioCubitState({
    required this.badStationIds,
  });

  @override
  List<Object> get props => [];

  StationStatus checkButtonState(Station station);

  final List<String> badStationIds;
}

enum StationStatus { canPlay, canPause, error }

abstract class RadioCubitStateWithStation extends RadioCubitState {
  const RadioCubitStateWithStation({
    required this.station,
    required super.badStationIds,
  });
  final Station station;

  @override
  List<Object> get props => [station, ...badStationIds];
}

class RadioCubitStopped extends RadioCubitState {
  const RadioCubitStopped({required super.badStationIds});

  @override
  StationStatus checkButtonState(Station station) {
    if (badStationIds.contains(station.id)) {
      return StationStatus.error;
    }

    return StationStatus.canPlay;
  }
}

class RadioCubitPlaying extends RadioCubitStateWithStation {
  const RadioCubitPlaying({
    required super.station,
    required super.badStationIds,
  });

  @override
  StationStatus checkButtonState(Station station) {
    if (badStationIds.contains(station.id)) {
      return StationStatus.error;
    }

    return station != this.station
        ? StationStatus.canPlay
        : StationStatus.canPause;
  }
}

class RadioCubitWaiting extends RadioCubitStateWithStation {
  const RadioCubitWaiting({
    required super.station,
    required super.badStationIds,
  });

  @override
  StationStatus checkButtonState(Station station) {
    if (badStationIds.contains(station.id)) {
      return StationStatus.error;
    }

    return station != this.station
        ? StationStatus.canPlay
        : StationStatus.canPause;
  }
}

class RadioCubitPaused extends RadioCubitStateWithStation {
  const RadioCubitPaused({
    required super.station,
    required super.badStationIds,
  });

  @override
  StationStatus checkButtonState(Station station) {
    if (badStationIds.contains(station.id)) {
      return StationStatus.error;
    }

    return StationStatus.canPlay;
  }
}
