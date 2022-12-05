import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  CountriesCubit() : super(CountriesInitial());

  void load(){
    
  }
}
