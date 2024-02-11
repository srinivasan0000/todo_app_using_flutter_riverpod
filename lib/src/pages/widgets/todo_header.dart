import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/active_todo/active_todo.dart';
import '../providers/todo_list/todo_list.dart';

class TodoHeader extends ConsumerWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTodoCount = ref.watch(activeTodoCountProvider);
    final todos = ref.watch(todoListProvider);
    return Row(
      children: [
        const Text("Todo"),
        const SizedBox(width: 10),
        Text(
            "$activeTodoCount / ${todos.length} item${todos.length > 1 ? 's' : ''} left")
      ],
    );
  }
}
