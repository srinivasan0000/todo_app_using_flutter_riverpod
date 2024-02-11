import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/todo_model.dart';

part 'todo_list.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  List<Todo> build() {
    return [
      const Todo(id: "1", description: 'Clean the room'),
      const Todo(id: "2", description: 'Wash the disk'),
      const Todo(id: "3", description: 'Do homework'),
    ];
  }

  void addTodo(String description) {
    state = [...state, Todo.create(description)];
  }

  void editTodo(String id, String description) {
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(description: description) else todo
    ];
  }

  void toggleTodoStatus(String id) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          todo.copyWith(isCompleted: !todo.isCompleted)
        else
          todo
    ];
  }

  void removeTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id != id) todo
    ];
  }
}

@Riverpod(dependencies: [])
Todo todoItem(TodoItemRef ref) {
  throw UnimplementedError();
}
