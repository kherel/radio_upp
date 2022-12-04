import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> getItSetup() async {
  await getIt.allReady();
}
