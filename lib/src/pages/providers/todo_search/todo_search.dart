import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_search.g.dart';

@riverpod
class TodoSearch extends _$TodoSearch {
  @override
  String build() {
    return '';
  }

  void setSearchTerm(String searchTerm) {
    state = searchTerm;
  }
}
