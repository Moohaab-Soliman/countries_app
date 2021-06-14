import 'package:countries_app_test/boxes/boxes.dart';
import 'package:countries_app_test/components/list_component.dart';
import 'package:countries_app_test/model/country_model.dart';
import 'package:countries_app_test/widgets/info_widget.dart';
import 'package:countries_app_test/widgets/navigation_menu';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../api.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<Map<String, dynamic>>? allCountries;
  List<Map<String, dynamic>>? countries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Favourite Countries",
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

                allCountries = (result.data!['countries'] as List<dynamic>)
                    .cast<Map<String, dynamic>>();
                countries ??= allCountries;

                return Column(
                  children: <Widget>[
                    countriesList(),
                  ],
                );
              },
            );
          }),
    );
  }

  Widget countriesList() {
    List favouriteCountries = Boxes.getFavourites().values.toList();

    return Expanded(
      child: favouriteCountries.length == 0
          ? info(icon: FontAwesomeIcons.globe, text: 'No Favourite countries')
          : ListView.builder(
              itemCount: Boxes.getFavourites().length,
              itemBuilder: (_, int index) {
                var country = favouriteCountries[index];

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: ListComponent(
                    country: country,
                  ),
                );
              },
            ),
    );
  }
}
