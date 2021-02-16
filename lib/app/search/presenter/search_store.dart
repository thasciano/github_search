import 'package:async/async.dart';
import 'package:github_search/app/search/domain/usecases/search_by_text.dart';
import 'package:github_search/app/search/presenter/states/state.dart';
import 'package:mobx/mobx.dart';

part 'search_store.g.dart';

class SearchStore = _SearchStoreBase with _$SearchStore;

abstract class _SearchStoreBase with Store {
  final SearchByText usecase;
  CancelableOperation cancellableOperation;

  _SearchStoreBase(this.usecase) {
    reaction((_) => searchText, (text) async {
      stateReaction(text, cancellableOperation);
    }, delay: 500);
  }

  Future stateReaction(String text,
      [CancelableOperation cancellableOperation]) async {
    await cancellableOperation?.cancel();
    cancellableOperation =
        CancelableOperation<SearchState>.fromFuture(makeSearch(text));
    if (text.isEmpty) {
      setState(SearchStart());
      return;
    }

    setState(SearchLoading());

    setState(await cancellableOperation.valueOrCancellation(SearchLoading()));
  }

  Future<SearchState> makeSearch(String text) async {
    var result = await usecase(text);
    return result.fold((l) => SearchError(l), (r) => SearchSucess(r));
  }

  @observable
  String searchText = "";

  @observable
  SearchState state = SearchStart();

  @action
  setSearchText(String value) => searchText = value;

  @action
  setState(SearchState value) => state = value;

  // SearchBloc(this.usecase) : super(SearchStart());

  // @override
  // Stream<SearchState> mapEventToState(String searchText) async* {
  //   yield SearchLoading();
  //   final result = await usecase(searchText);
  //   yield result.fold((l) => SearchError(l), (r) => SearchSucess(r));
  // }

  // @override
  // Stream<Transition<String, SearchState>> transformEvents(
  //     Stream<String> events, transitionFn) {
  //   return super.transformEvents(
  //       events.debounceTime(Duration(milliseconds: 800)), transitionFn);
  // }
}
