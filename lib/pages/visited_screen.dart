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

class VisitedScreen extends StatefulWidget {
  @override
  _VisitedScreenState createState() => _VisitedScreenState();
}

class _VisitedScreenState extends State<VisitedScreen> {
  List<Map<String, dynamic>>? allCountries;
  List<Map<String, dynamic>>? countries;
  List visitedCountries = Boxes.getVisited().values.toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Visited Countries",
            style: TextStyle(color: Colors.black87),
          ),
        ),
      ),
      drawer: NavDrawer(),
      body: ValueListenableBuilder<Box<CountryModel>>(
          valueListenable: Boxes.getVisited().listenable(),
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
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      height: 80,
                      child: Card(
                        child: Center(
                          child: Text(
                            'Number of Visited Countries : ' +
                                visitedCountries.length.toString(),
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    countriesList(),
                  ],
                );
              },
            );
          }),
    );
  }

  Widget countriesList() {
    return Expanded(
      child: visitedCountries.length == 0
          ? info(
              icon: FontAwesomeIcons.planeSlash, text: 'No Visited Countries')
          : ListView.builder(
              itemCount: Boxes.getVisited().length,
              itemBuilder: (_, int index) {
                var country = visitedCountries[index];
                return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        ListComponent(
                          country: country,
                        ),
                      ],
                    ));
              },
            ),
    );
  }
}
