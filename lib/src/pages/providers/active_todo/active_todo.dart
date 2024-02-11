import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../todo_list/todo_list.dart';

part 'active_todo.g.dart';

@riverpod
int activeTodoCount(ActiveTodoCountRef ref) {
  final todos = ref.watch(todoListProvider);
  return todos.where((todo) => !todo.isCompleted).length;
}
