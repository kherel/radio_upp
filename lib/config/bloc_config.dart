import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:radio_upp/logic/cubits/local_stations/local_stations_cubit.dart';

class BlocAndProviderConfig extends StatelessWidget {
  const BlocAndProviderConfig({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => LocalStationsCubit()..init()),
      ],
      child: child,
    );
  }
}
