import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search/app/app_widget.dart';
import 'package:github_search/app/search/presenter/search_store.dart';

import 'search/domain/usecases/search_by_text.dart';
import 'search/external/datasources/github_datasource.dart';
import 'search/infra/repositories/search_repository_impl.dart';
import 'search/presenter/search_page.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => GithubDatasource(i())),
        Bind((i) => SearchRepositoryImpl(i())),
        Bind((i) => SearchByTextImpl(i())),
        Bind((i) => SearchStore(i())),
      ];

  @override
  Widget get bootstrap => AppWidget();

  @override
  List<ModularRouter> get routers => [
    ModularRouter(Modular.initialRoute, child: (_, __) => SearchPage()),
  ];
}
