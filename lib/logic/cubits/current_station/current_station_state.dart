part of 'current_station_cubit.dart';

class CurrentStationState extends Equatable {
  const CurrentStationState({
    required this.isPlaying,
    required this.station,
  });

  final bool isPlaying;
  final Station station;

  @override
  List<Object> get props => [
        isPlaying,
        station,
      ];
}
