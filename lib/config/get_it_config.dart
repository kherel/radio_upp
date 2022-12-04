import 'package:get_it/get_it.dart';
import 'package:radio_upp/logic/get_it/navigator.dart';

final getIt = GetIt.instance;

Future<void> getItSetup() async {
  getIt.registerSingleton<NavigationService>(NavigationService());
}
