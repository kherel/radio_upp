import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radio_upp/api_maps/radio.dart';
import 'package:radio_upp/logic/models/country.dart';
import 'package:radio_upp/logic/models/genre.dart';
import 'package:radio_upp/logic/models/station.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(StationsInitial());

  var api = RadioApi();

  void search({Genre? genre, Country? country}) async {
    emit(StationsLoading(genre: genre, country: country));

    var res = await api.search(country: country, genre: genre);
    emit(StationsLoaded(
      stations: res,
      genre: genre,
      country: country,
    ));
  }
}
