import 'package:radio_upp/logic/models/station.dart';

class ListeningHistoryItem {
  final Station station;
  final Duration duration;

  ListeningHistoryItem({
    required this.station,
    required this.duration,
  });
}
