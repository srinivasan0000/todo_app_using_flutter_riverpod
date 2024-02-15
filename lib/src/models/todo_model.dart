import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

Uuid _uuid = const Uuid();

@freezed
class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String description,
    required DateTime createdAt,
   
    @Default(false) bool isCompleted,
  }) = _Todo;

  factory Todo.create(String description) => Todo(id: _uuid.v4(), description: description, createdAt: DateTime.now());

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

enum Filter {
  all,
  active,
  completed,
}

enum SortBy {
  completed,
  active,
  date,
  dateDescending
}
