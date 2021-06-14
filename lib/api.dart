import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: HttpLink('https://countries.trevorblades.com/'),
  ),
);

final String getCountriesQuery = """
query {
 countries {
    name
    code
    currency
    emoji
    states {
      code
      name
    }
  }
 }
""";

QueryOptions queryOptions() {
  return QueryOptions(
    document: gql(getCountriesQuery),
  );
}
