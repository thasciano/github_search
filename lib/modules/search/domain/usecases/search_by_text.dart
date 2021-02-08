import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:dartz/dartz.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';

abstract class SearchByText {
  Either<FailureSearch, Future<List<ResultSearch>>> call(String searchText);
}