import 'package:countries_app_test/api.dart';
import 'package:countries_app_test/pages/countries_screen.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'components/navigator.dart';
import 'model/country_model.dart';
import 'my_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();

  Hive.registerAdapter(CountryModelAdapter());
  await Hive.openBox<CountryModel>('favourites');
  await Hive.openBox<CountryModel>('visited');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        initialRoute: '/',
        routes: myRoutes,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFF9F0F0),
          appBarTheme: AppBarTheme(
            color: Color(0xFFF7F0F0),
          ),
          cardColor: Color(0xFFFDFBFC),
        ),
      ),
    );
  }
}
