import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/todo_filter/todo_filter.dart';

import '../../models/todo_model.dart';

class FilterTodo extends ConsumerWidget {
  const FilterTodo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      children: [
        FilterButton(Filter.all),
        FilterButton(Filter.active),
        FilterButton(Filter.completed)
      ],
    );
  }
}

class FilterButton extends ConsumerWidget {
  const FilterButton(this.filter, {super.key});
  final Filter filter;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(todoFilterProvider);
    return TextButton(
      child: Text(
        filter == Filter.all
            ? 'All'
            : filter == Filter.active
                ? 'Active'
                : 'Completed',
        style: TextStyle(
            fontSize: 18,
            color: currentFilter == filter ? Colors.blue : Colors.grey),
      ),
      onPressed: () {
        ref.read(todoFilterProvider.notifier).changeFilter(filter);
      },
    );
  }
}
