// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_list.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoItemHash() => r'598955ebdb957dc7bf5ec5149a9d38a113b15cb9';

/// See also [todoItem].
@ProviderFor(todoItem)
final todoItemProvider = AutoDisposeProvider<Todo>.internal(
  todoItem,
  name: r'todoItemProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todoItemHash,
  dependencies: const <ProviderOrFamily>[],
  allTransitiveDependencies: const <ProviderOrFamily>{},
);

typedef TodoItemRef = AutoDisposeProviderRef<Todo>;
String _$todoListHash() => r'8dd710f9ade0044c9def088fc5efa619f1a9809f';

/// See also [TodoList].
@ProviderFor(TodoList)
final todoListProvider =
    AutoDisposeAsyncNotifierProvider<TodoList, List<Todo>>.internal(
  TodoList.new,
  name: r'todoListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todoListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodoList = AutoDisposeAsyncNotifier<List<Todo>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
