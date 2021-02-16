import 'package:github_search/app/search/domain/entities/result_search.dart';
import 'package:github_search/app/search/domain/errors/errors.dart';

abstract class SearchState {}

class SearchSucess implements SearchState {
  final List<ResultSearch> list;

  SearchSucess(this.list);
}

class SearchError implements SearchState {
  final FailureSearch error;

  SearchError(this.error);
}

class SearchLoading implements SearchState {}

class SearchStart implements SearchState {}
