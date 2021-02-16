import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search/app/search/presenter/search_store.dart';
import 'package:github_search/app/search/presenter/states/state.dart';
// import 'package:flutter_mobx/flutter'

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = Modular.get<SearchStore>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: bloc.setSearchText,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Search...'),
            ),
          ),
          Expanded(
            child: Observer(builder: (_) {
              final state = bloc.state;
              if (state is SearchStart) {
                return Center(
                  child: Text('Digite um texto'),
                );
              }
              if (state is SearchError) {
                return Center(
                  child: Text('Houve um error'),
                );
              }

              if (state is SearchLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final list = (state as SearchSucess).list;
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (_, id) {
                    final item = list[id];
                    return ListTile(
                      leading: item.image == null
                          ? Container()
                          : CircleAvatar(
                              backgroundImage: NetworkImage(item.image),
                            ),
                      title: Text(item.nickname ?? ""),
                      subtitle: Text(item.name ?? ""),
                    );
                  });
            }),
          )
        ],
      ),
    );
  }
}
