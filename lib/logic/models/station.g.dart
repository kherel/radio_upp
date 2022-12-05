// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Station _$StationFromJson(Map<String, dynamic> json) => Station(
      id: json['i'] as String,
      name: json['n'] as String,
      genre: Serialization.genreFromString(json['d'] as String),
      country: Serialization.countryFromString(json['c'] as String),
      logoUrl: json['l'] as String,
      streamURl: json['u'] as String,
    );

Map<String, dynamic> _$StationToJson(Station instance) => <String, dynamic>{
      'i': instance.id,
      'n': instance.name,
      'd': Serialization.stringIdFromGenre(instance.genre),
      'c': Serialization.stringIdFromCountry(instance.country),
      'l': instance.logoUrl,
      'u': instance.streamURl,
    };
