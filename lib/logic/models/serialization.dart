import 'package:radio_upp/logic/models/country.dart';
import 'package:radio_upp/logic/models/genre.dart';

class Serialization {
  static Country? countryFromString(String string) {
    for (var c in Country.values) {
      if (c.name == string) {
        return c;
      }
    }
    return null;
  }

  static String? stringIdFromCountry(Country? country) {
    if (country == null) {
      return null;
    }
    return country.name;
  }

  static Genre? genreFromString(String string) {
    if (allGenres[int.parse(string)] == null) {
      print('new g: $string');
    }
    return allGenres[int.parse(string)];
  }

  static String? stringIdFromGenre(Genre? genre) {
    if (genre == null) {
      return null;
    }
    return genre.id;
  }
}
