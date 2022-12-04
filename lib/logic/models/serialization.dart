import 'package:radio_upp/logic/models/genre.dart';

class Serialization {
  static Genre genreFromString(String string) {
    return allGenres[int.parse(string)]!;
  }

    static String stringIdFromGenre(Genre genre) {
    return genre.id;
  }
}
