import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/todo_search/todo_search.dart';
import '../../utils/debounce.dart';

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
      onChanged: (value) {
        if (value.isNotEmpty) {
          _debounce.run(() {
            ref.read(todoSearchProvider.notifier).setSearchTerm(value);
          });
        }
      },
    );
  }
}
