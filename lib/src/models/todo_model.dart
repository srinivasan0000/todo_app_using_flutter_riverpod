import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'todo_model.freezed.dart';

Uuid _uuid = const Uuid();

@freezed
class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String description,
    @Default(false) bool isCompleted,
  }) = _Todo;

  factory Todo.create(String description) =>
      Todo(id: _uuid.v4(), description: description);
}

enum Filter {
  all,
  active,
  completed,
}
