import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/todo_model.dart';
import '../todo_filter/todo_filter.dart';
import '../todo_list/todo_list.dart';
import '../todo_search/todo_search.dart';

part 'filter_todo.g.dart';

@riverpod
List<Todo> filteredTodos(FilteredTodosRef ref) {
  final todos = ref.watch(todoListProvider);
  final filter = ref.watch(todoFilterProvider);
  final search = ref.watch(todoSearchProvider);

  List<Todo> filteredTodos;

  filteredTodos = switch (filter) {
    Filter.all => todos.value!,
    Filter.active => todos.value!.where((todo) => !todo.isCompleted).toList(),
    Filter.completed => todos.value!.where((todo) => todo.isCompleted).toList(),
  };

  if (search.isNotEmpty) {
    filteredTodos = filteredTodos
        .where((element) =>
            element.description.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  return filteredTodos;
}
