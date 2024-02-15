import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/todo_filter/todo_filter.dart';

import '../../models/todo_model.dart';
import '../providers/todo_sort/todo_sort.dart';

class FilterTodo extends ConsumerWidget {
  const FilterTodo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortList = ref.watch(todoSortProvider);
    return Row(
      children: [
        const FilterButton(Filter.all),
        const FilterButton(Filter.active),
        const FilterButton(Filter.completed),
        const Spacer(),
        PopupMenuButton(
          icon: const Icon(Icons.sort),
          initialValue: sortList,
          onSelected: (SortBy item) {
            ref.read(todoSortProvider.notifier).changeSort(item);
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<SortBy>>[
            const PopupMenuItem<SortBy>(
              value: SortBy.active,
              child: Text("Active Task"),
            ),
            const PopupMenuItem<SortBy>(
              value: SortBy.completed,
              child: Text("Completed Task"),
            ),
            const PopupMenuItem<SortBy>(
              value: SortBy.date,
              child: Text('Date'),
            ),
            const PopupMenuItem<SortBy>(
              value: SortBy.dateDescending,
              child: Text('Date Dsc'),
            )
          ],
        )
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
    return Row(
      children: [
        TextButton(
          child: Text(
            filter == Filter.all
                ? 'All'
                : filter == Filter.active
                    ? 'Active'
                    : 'Completed',
            style: TextStyle(fontSize: 18, color: currentFilter == filter ? Colors.blue : Colors.grey),
          ),
          onPressed: () {
            ref.read(todoFilterProvider.notifier).changeFilter(filter);
          },
        ),
      ],
    );
  }
}
