import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/todo_model.dart';

import '../providers/todo_list/todo_list.dart';

class TodoHeader extends ConsumerStatefulWidget {
  const TodoHeader({super.key});

  @override
  ConsumerState<TodoHeader> createState() => _TodoHeaderState();
}

class _TodoHeaderState extends ConsumerState<TodoHeader> {
  Widget prevTodoCountWidget = const SizedBox.shrink();

  Widget getActiveTodoCount(List<Todo> todos) {
    final totalCount = todos.length;
    final activeTodoCount = todos.where((todo) => !todo.isCompleted).toList().length;

    prevTodoCountWidget = Text(
      '($activeTodoCount/$totalCount item${activeTodoCount != 1 ? "s" : ""} left)',
      style: TextStyle(
        fontSize: 18.0,
        color: Colors.blue[900],
      ),
    );

    return prevTodoCountWidget;
  }

  @override
  Widget build(BuildContext context) {
    final todoListState = ref.watch(todoListProvider);
    // todoListState.maybeWhen(
    //   skipLoadingOnRefresh: false,
    //   loading: () {
    //     context.loaderOverlay.show();
    //   },
    //   orElse: () {
    //     context.loaderOverlay.hide();
    //   },
    // );


    final todos = ref.watch(todoListProvider);
    return Row(
      children: [const Text("Todo"), const SizedBox(width: 10), Text("$getActiveTodoCount / ${todos.value!.length} item${todos.value!.length > 1 ? 's' : ''} left")],
    );
  }
}
