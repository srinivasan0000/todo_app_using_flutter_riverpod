import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/todo_list/todo_list.dart';

class NewTodo extends ConsumerStatefulWidget {
  const NewTodo({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewTodoState();
}

class _NewTodoState extends ConsumerState<NewTodo> {
  final TextEditingController newTodoTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    newTodoTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: newTodoTextController,
        decoration: const InputDecoration(
          hintText: 'What needs to be done?',
        ),
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            ref.read(todoListProvider.notifier).addTodo(value);

            newTodoTextController.clear();
          }
        });
  }
}
