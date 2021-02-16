import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/app/app_module.dart';
import 'package:github_search/app/search/domain/entities/result_search.dart';
import 'package:github_search/app/search/domain/usecases/search_by_text.dart';
import 'package:mockito/mockito.dart';

import 'app/search/external/datasources/github_datasource_test.dart';
import 'app/search/utils/github_response.dart';


class DioMoc extends Mock implements Dio {}

main() {
  final dio = DioMock();
  initModule(AppModule(), changeBinds: [
    Bind<Dio>((i) => dio)
  ]);
  test('deve recuperar o usecase sem erro', () {
    final usecase = Modular.get<SearchByText>();
    expect(usecase, isA<SearchByText>());
  });

  test('deve trazer uma lista de ResultSearch', () async {
     when(dio.get(any)).thenAnswer(
        (_) async => Response(data: jsonDecode(githubResult), statusCode: 200));
        
    final usecase = Modular.get<SearchByText>();
    final result = await usecase('thasciano');
    expect(result | null, isA<List<ResultSearch>>());
  });
}
