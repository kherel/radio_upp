import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radio_upp/logic/models/station.dart';

part 'current_station_state.dart';

class CurrentStationCubit extends Cubit<CurrentStationState?> {
  CurrentStationCubit() : super(null);

  void play() {}

  void pause() {}

  void connect() {}
}
