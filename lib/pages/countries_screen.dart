import 'package:countries_app_test/boxes/boxes.dart';
import 'package:countries_app_test/components/list_component.dart';
import 'package:countries_app_test/components/search_widget.dart';
import 'package:countries_app_test/model/country_model.dart';
import 'package:countries_app_test/widgets/info_widget.dart';
import 'package:countries_app_test/widgets/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../api.dart';

class CountriesScreen extends StatefulWidget {
  @override
  _CountriesScreenState createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  List<Map<String, dynamic>>? allCountries;
  List<Map<String, dynamic>>? countries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Countries",
            style: TextStyle(color: Colors.black87),
          ),
        ),
      ),
      drawer: NavDrawer(),
      body: ValueListenableBuilder<Box<CountryModel>>(
        valueListenable: Boxes.getFavourites().listenable(),
        builder: (context, box, _) {
          return Query(
            options: queryOptions(),
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              if (result.isLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (result.data == null) {
                return info(
                  icon: Icons.cloud_queue,
                  text: 'Connect to the internet',
                );
              }

              // it can be either Map or List
              allCountries = (result.data!['countries'] as List<dynamic>)
                  .cast<Map<String, dynamic>>();
              countries ??= allCountries;

              return Column(
                children: <Widget>[
                  searchField(),
                  countriesList(),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget searchField() {
    return Container(
      width: double.infinity,
      height: 38,
      margin: const EdgeInsets.all(15.0),
      child: SearchBox(textChanged: onSearchTextChanged),
    );
  }

  void onSearchTextChanged(String text) {
    setState(() {
      if (text.isEmpty) countries = allCountries;

      countries = allCountries!.where((c) {
        String country = (c['name'] as String).toLowerCase();
        String filter = text.toLowerCase();
        return country.contains(filter);
      }).toList();
      setState(() {
        countries = countries;
      });
    });
  }

  Widget countriesList() {
    return Expanded(
      child: countries?.length == null || countries?.length == 0
          ? info(icon: FontAwesomeIcons.globe, text: 'No countries')
          : ListView.builder(
              itemCount: countries == null ? 0 : countries?.length,
              itemBuilder: (_, int index) {
                CountryModel country = CountryModel.fromMap(countries![index]);

                return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: ListComponent(country: country));
              },
            ),
    );
  }
}
//
