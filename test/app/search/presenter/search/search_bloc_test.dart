import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/app/search/domain/entities/result_search.dart';
import 'package:github_search/app/search/domain/errors/errors.dart';
import 'package:github_search/app/search/domain/usecases/search_by_text.dart';
import 'package:github_search/app/search/presenter/search_store.dart';
import 'package:github_search/app/search/presenter/states/state.dart';
import 'package:mockito/mockito.dart';

class SearchByTextMock extends Mock implements SearchByText {}

main() {
  final usecase = SearchByTextMock();

  final bloc = SearchStore(usecase);

  test('deve retornar os estados na ordem correta', () {
    when(usecase.call(any)).thenAnswer((_) async => Right(<ResultSearch>[]));
    expect(
        bloc,
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchSucess>(),
        ]));
        // bloc.add('thasciano');
  });

   test('deve retornar error', () {
    when(usecase.call(any)).thenAnswer((_) async => Left(InvalidTextError()));
    expect(
        bloc,
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchError>(),
        ]));
        // bloc.add('thasciano');
  });
}
