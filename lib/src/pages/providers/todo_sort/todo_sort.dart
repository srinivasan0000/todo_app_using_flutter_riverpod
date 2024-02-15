import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/todo_model.dart';
part 'todo_sort.g.dart';

@riverpod
class TodoSort extends _$TodoSort {
  @override
  SortBy build() {
    return SortBy.active;
  }

  void changeSort(SortBy newSort) {
    state = newSort;
  }
}
