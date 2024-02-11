import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/filter_todo/filter_todo.dart';

import '../../models/todo_model.dart';
import '../providers/todo_list/todo_list.dart';

class ShowTodo extends ConsumerWidget {
  const ShowTodo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredTodo = ref.watch(filteredTodosProvider);
    return ListView.separated(
        itemBuilder: (context, index) {
          final todo = filteredTodo[index];
          return ProviderScope(
              overrides: [todoItemProvider.overrideWith((ref) => todo)],
              child: const _TodoItem());
        },
        separatorBuilder: (context, index) => const Divider(color: Colors.grey),
        itemCount: filteredTodo.length);
  }
}

class _TodoItem extends ConsumerWidget {
  const _TodoItem({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(todoItemProvider);
    return ListTile(
      onTap: () async {
        await showDialog(
            context: context, builder: (context) => ConfiremEditDialog(todo));
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
        decoration: InputDecoration(
            errorText: error ? "Value can't be empty" : null,
            hintText: "Enter new value"),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel")),
        TextButton(
            onPressed: () {
              if (_editController.text.isNotEmpty) {
                ref
                    .read(todoListProvider.notifier)
                    .editTodo(widget.todo.id, _editController.text);
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
