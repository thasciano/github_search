import 'package:github_search/app/search/infra/models/result_search_model.dart';

abstract class SearchDatasource {
  // final SearchDatasource datasource;

  // SearchDatasource(this.datasource);

  Future<List<ResultSearchModel>> getSearch(String searchText);
}
