import 'package:countries_app_test/model/country_model.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<CountryModel> getFavourites() => Hive.box('favourites');
  static Box<CountryModel> getVisited() => Hive.box('visited');
}
