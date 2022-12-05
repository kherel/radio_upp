import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:radio_upp/api_maps/rapid_api.dart';
import 'package:radio_upp/logic/models/country.dart';
import 'package:radio_upp/logic/models/genre.dart';
import 'package:radio_upp/logic/models/station.dart';

import 'dart:async';

const url =
    'https://30-000-radio-stations-and-music-charts.p.rapidapi.com/rapidapi';

const host = '30-000-radio-stations-and-music-charts.p.rapidapi.com';

class RadioApi extends RapidApi {
  Future<List<Station>> search({
    Country? country,
    Genre? genre,
  }) async {
    var client = await getClient();

    var res = await client.get(
      url,
      queryParameters: {
        'genre': genre?.id ?? 'ALL',
        'country': country?.name ?? 'ALL',
        'search_keyword': 'ALL'
      },
    );
    client.close();

    if (res.data is List) {
      return [];
    }
    return (res.data['results'] as List).map<Station>((json) {
      return Station.fromJson(json);
    }).toList();
  }

  @override
  @protected
  FutureOr<BaseOptions> get options async {
    var options = await super.options;
    options.headers = {
      ...options.headers,
      'X-RapidAPI-Host': host,
    };
    return options;
  }
}
