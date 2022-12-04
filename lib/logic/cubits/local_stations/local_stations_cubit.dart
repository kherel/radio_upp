import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radio_upp/api_maps/radio.dart';
import 'package:radio_upp/logic/models/station.dart';

part 'local_stations_state.dart';

class LocalStationsCubit extends Cubit<LocalStationsState> {
  LocalStationsCubit() : super(LocalStationsInitial());

  var api = RadioApi();

  void init() async {
    emit(LocalStationsLoading());
    // final geo = await Ipify.geo(FlutterConfig.get("IPIFY"));
    // var countryCode = geo.location?.country;

    // if (countryCode == null) {
    //   emit(LocalStationsNoLocation());
    // }
    // var countryCode = 'ES';
    // var country = Country.values.firstWhere(
    //   (element) {
    //     return element.name == countryCode;
    //   },
    // );
    // var res = await api.search(country: country);

    // emit(LocalStationsLoaded(res));
  }
}
