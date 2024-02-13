import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/todo_model.dart';
import '../../../repositories/providers/todo_repository_provider.dart';

part 'todo_list.g.dart';

@riverpod
class TodoList extends _$TodoList {
@override
  FutureOr<List<Todo>> build() {
    print('[todoListProvider] initialized');
    ref.onDispose(() {
      print('[todoListProvider] disposed');
    });
    return _getTodos();
  }
  Future<List<Todo>> _getTodos() {
    return ref.read(todosRepositoryProvider).getTodos();
  }
  Future<void> addTodo(String desc) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final newTodo = Todo.create(desc);

      await ref.read(todosRepositoryProvider).addTodo(todo: newTodo);

      return [...state.value!, newTodo];
    });
  }


   Future<void> editTodo(String id, String desc) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(todosRepositoryProvider).editTodo(id: id, desc: desc);

      return [
        for (final todo in state.value!)
          if (todo.id == id) todo.copyWith(description:  desc) else todo
      ];
    });
  }
Future<void> toggleTodoStatus(String id) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(todosRepositoryProvider).toggleTodo(id: id);

      return [
        for (final todo in state.value!)
          if (todo.id == id) todo.copyWith(isCompleted: !todo.isCompleted) else todo
      ];
    });
  }

  Future<void> removeTodo(String id) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(todosRepositoryProvider).removeTodo(id: id);

      return [
        for (final todo in state.value!)
          if (todo.id != id) todo
      ];
    });
  }
}

@Riverpod(dependencies: [])
Todo todoItem(TodoItemRef ref) {
  throw UnimplementedError();
}
