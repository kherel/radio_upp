part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class StationsInitial extends SearchState {}

class StationsLoading extends SearchState {}

class StationsLoaded extends SearchState {
  final List<Station> stations;

  const StationsLoaded(this.stations);

  @override
  List<Object> get props => stations;
}
