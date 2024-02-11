import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/filter_todo.dart';
import 'widgets/new_todo.dart';
import 'widgets/search_todo.dart';
import 'widgets/show_todo.dart';
import 'widgets/todo_header.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  Scaffold(
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              TodoHeader(),
              NewTodo(),
              SearchTodo(),
              FilterTodo(),
              Expanded(child: ShowTodo())
            ],
          ),
        ),
      ),
    );
  }
}
