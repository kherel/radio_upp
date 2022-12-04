part of 'local_stations_cubit.dart';

abstract class LocalStationsState extends Equatable {
  const LocalStationsState();

  @override
  List<Object> get props => [];
}

class LocalStationsInitial extends LocalStationsState {}

class LocalStationsLoading extends LocalStationsState {}
class LocalStationsNoLocation extends LocalStationsState {}

class LocalStationsLoaded extends LocalStationsState {
  final List<Station> stations;

  const LocalStationsLoaded(this.stations);

  @override
  List<Object> get props => stations;
}
