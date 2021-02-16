import 'package:github_search/app/search/domain/entities/result_search.dart';
import 'package:github_search/app/search/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:github_search/app/search/domain/repositories/search_repository.dart';

abstract class SearchByText {
  Future<Either<FailureSearch, List<ResultSearch>>> call(String searchText);
}

class SearchByTextImpl implements SearchByText {

  final SearchRepository repository;

  SearchByTextImpl(this.repository);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> call(
      String searchText) async {
        if(searchText == null || searchText.isEmpty){
          return Left(InvalidTextError());
        }

        return repository.search(searchText);
  }
}
