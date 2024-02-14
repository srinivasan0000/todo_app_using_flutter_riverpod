import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/debounce.dart';
import '../providers/todo_search/todo_search.dart';

class SearchTodo extends ConsumerStatefulWidget {
  const SearchTodo({super.key});

  @override
  ConsumerState<SearchTodo> createState() => _SearchTodoState();
}

class _SearchTodoState extends ConsumerState<SearchTodo> {
  final _debounce = Debounce(milliseconds: 1000);
  @override
  void dispose() {
    _debounce.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Search todo',
        prefixIcon: Icon(Icons.search),
        filled: true,
      ),
      onChanged: (String? value) {
        if (value != null) {
          _debounce.run(() {
            ref.watch(todoSearchProvider.notifier).setSearchTerm(value);
          });
        }
      },
    );
  }
}
