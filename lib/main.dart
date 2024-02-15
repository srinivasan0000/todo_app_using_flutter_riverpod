import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'src/pages/providers/todo_theme/todo_theme.dart';

import 'src/pages/todo_page.dart';
import 'src/repositories/hive_todo_repository.dart';
import 'src/repositories/providers/todo_repository_provider.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('todos');
  runApp(ProviderScope(overrides: [todosRepositoryProvider.overrideWithValue(HiveTodosRepository())], child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(todoThemeProvider);
    return MaterialApp(
      title: 'Todo App Using Riverpod',
      theme: switch (currentTheme) { ThemeState.light => ThemeData.light(), ThemeState.dark => ThemeData.dark() },
      home: const TodoPage(),
    );
  }
}
