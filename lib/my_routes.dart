import 'package:countries_app_test/pages/countries_screen.dart';
import 'package:countries_app_test/pages/favourite_screen.dart';
import 'package:countries_app_test/pages/visited_screen.dart';
import 'package:flutter/material.dart';

var myRoutes = <String, WidgetBuilder>{
  '/': (context) => CountriesScreen(),
  '/favourites': (context) => FavouriteScreen(),
  '/visited': (context) => VisitedScreen(),
};
