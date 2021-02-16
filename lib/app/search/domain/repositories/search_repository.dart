import 'package:dartz/dartz.dart';
import 'package:github_search/app/search/domain/entities/result_search.dart';
import 'package:github_search/app/search/domain/errors/errors.dart';

abstract class SearchRepository {
    Future<Either<FailureSearch, List<ResultSearch>>> search(String searchText);
}
