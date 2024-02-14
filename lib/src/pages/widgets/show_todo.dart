import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/todo_filter/todo_filter.dart';
import '../providers/todo_search/todo_search.dart';

import '../../models/todo_model.dart';
import '../providers/todo_list/todo_list.dart';

class ShowTodo extends ConsumerStatefulWidget {
  const ShowTodo({super.key});

  @override
  ConsumerState<ShowTodo> createState() => _ShowTodoState();
}

class _ShowTodoState extends ConsumerState<ShowTodo> {
  List<Todo> filterTodos(List<Todo> allTodos) {
    final filter = ref.watch(todoFilterProvider);
    final search = ref.watch(todoSearchProvider);

    List<Todo> tempTodos;

    tempTodos = switch (filter) {
      Filter.active => allTodos.where((todo) => !todo.isCompleted).toList(),
      Filter.completed => allTodos.where((todo) => todo.isCompleted).toList(),
      Filter.all => allTodos,
    };

    if (search.isNotEmpty) {
      tempTodos = tempTodos.where((todo) => todo.description.toLowerCase().contains(search.toLowerCase())).toList();
    }

    return tempTodos;
  }

  Widget prevTodosWidget = const SizedBox.shrink();
  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<List<Todo>>>(todoListProvider, (previous, next) {
      next.whenOrNull(
        error: (e, st) {
          if (!next.isLoading) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    'Error',
                    textAlign: TextAlign.center,
                  ),
                  content: Text(
                    e.toString(),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            );
          }
        },
      );
    });

    final todoListState = ref.watch(todoListProvider);

    return todoListState.when(
      skipError: true,
      data: (List<Todo> allTodos) {
        if (allTodos.isEmpty) {
          prevTodosWidget = const Center(
            child: Text(
              'Enter some todo',
              style: TextStyle(fontSize: 20),
            ),
          );
          return prevTodosWidget;
        }

        final filteredTodos = filterTodos(allTodos);

        prevTodosWidget = ListView.separated(
          itemCount: filteredTodos.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(color: Colors.grey);
          },
          itemBuilder: (BuildContext context, int index) {
            final todo = filteredTodos[index];
            return ProviderScope(
              overrides: [
                todoItemProvider.overrideWithValue(todo),
              ],
              child: const _TodoItem(),
            );
          },
        );
        return prevTodosWidget;
      },
      error: (error, _) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                error.toString(),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  ref.invalidate(todoListProvider);
                },
                child: const Text(
                  'Please Retry!',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        );
      },
      loading: () {
        return prevTodosWidget;
      },
    );
  }
}

class _TodoItem extends ConsumerWidget {
  const _TodoItem({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(todoItemProvider);
    return ListTile(
      onTap: () async {
        await showDialog(context: context, builder: (context) => ConfiremEditDialog(todo));
      },
      leading: Checkbox(
          onChanged: (value) {
            ref.read(todoListProvider.notifier).toggleTodoStatus(todo.id);
          },
          value: todo.isCompleted),
      title: Text(todo.description),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          final removeOrNot = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("Are You Sure ?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text("No")),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: const Text("Yes")),
                    ],
                  ));

          if (removeOrNot) {
            ref.read(todoListProvider.notifier).removeTodo(todo.id);
          }
        },
      ),
    );
  }
}

class ConfiremEditDialog extends ConsumerStatefulWidget {
  const ConfiremEditDialog(this.todo, {super.key});
  final Todo todo;

  @override
  ConsumerState<ConfiremEditDialog> createState() => _ConfiremEditDialogState();
}

class _ConfiremEditDialogState extends ConsumerState<ConfiremEditDialog> {
  late final TextEditingController _editController;
  bool error = false;
  @override
  void initState() {
    _editController = TextEditingController(text: widget.todo.description);
    super.initState();
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Todo"),
      content: TextField(
        autofocus: true,
        controller: _editController,
        decoration: InputDecoration(errorText: error ? "Value can't be empty" : null, hintText: "Enter new value"),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        TextButton(
            onPressed: () {
              if (_editController.text.isNotEmpty) {
                ref.read(todoListProvider.notifier).editTodo(widget.todo.id, _editController.text);
                Navigator.pop(context);
              } else {
                setState(() {
                  error = true;
                });
              }
            },
            child: const Text("Save"))
      ],
    );
  }
}
