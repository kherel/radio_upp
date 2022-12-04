import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:radio_upp/logic/models/serialization.dart';

import 'country.dart';
import 'genre.dart';

part 'station.g.dart';

@JsonSerializable()
class Station extends Equatable {
  @JsonKey(name: 'i')
  final String id;
  @JsonKey(name: 'n')
  final String name;
  @JsonKey(
    name: 'd',
    fromJson: Serialization.genreFromString,
    toJson: Serialization.stringIdFromGenre,
  )
  final Genre genre;
  @JsonKey(name: 'c')
  final Country country;
  @JsonKey(name: 'l')
  final String logoUrl;
  @JsonKey(name: 'u')
  final String streamURl;

  const Station({
    required this.id,
    required this.name,
    required this.genre,
    required this.country,
    required this.logoUrl,
    required this.streamURl,
  });

  factory Station.fromJson(Map<String, dynamic> json) =>
      _$StationFromJson(json);

  Map<String, dynamic> toJson() => _$StationToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        genre,
        country,
        logoUrl,
        streamURl,
      ];
}
