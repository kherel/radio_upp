part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class StationsInitial extends SearchState {}

class StationsLoading extends SearchState {
  const StationsLoading({
    this.genre,
    this.country,
  }) : assert(genre != null || country != null);

  final Genre? genre;
  final Country? country;
}

class StationsLoaded extends SearchState {
  final List<Station> stations;
  final Genre? genre;
  final Country? country;

  const StationsLoaded({
    this.genre,
    this.country,
    required this.stations,
  }) : assert(genre != null || country != null);

  @override
  List<Object> get props => stations;
}
