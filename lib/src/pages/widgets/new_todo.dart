import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/todo_list/todo_list.dart';

class NewTodo extends ConsumerWidget {
  NewTodo({super.key});

  final TextEditingController newTodoTextController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        child: Center(
          child: TextField(
            controller: newTodoTextController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  String? value = newTodoTextController.value.text;
                  if (value.isNotEmpty) {
                    ref.read(todoListProvider.notifier).addTodo(value);
                    newTodoTextController.clear();
                    FocusScope.of(context).unfocus();
                  }
                },
                icon: const Icon(Icons.send),
              ),
              hintText: 'Add Your Task Here',
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                ref.read(todoListProvider.notifier).addTodo(value);
                newTodoTextController.clear();
              }
            },
          ),
        ),
      ),
    );
  }
}
