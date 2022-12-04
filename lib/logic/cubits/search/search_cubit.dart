import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radio_upp/api_maps/radio.dart';
import 'package:radio_upp/logic/models/country.dart';
import 'package:radio_upp/logic/models/genre.dart';
import 'package:radio_upp/logic/models/station.dart';

part 'search_state.dart';

class Search extends Cubit<SearchState> {
  Search() : super(StationsInitial());

  var api = RadioApi();

  void search({Genre? genre, Country? country}) async {
    emit(StationsLoading());
    var res = await api.search(country: country, genre: genre);
    emit(StationsLoaded(res));
  }
}
