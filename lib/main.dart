import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/pages/todo_page.dart';
import 'src/repositories/hive_todo_repository.dart';
import 'src/repositories/providers/todo_repository_provider.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('todos');
  runApp(ProviderScope(overrides: [todosRepositoryProvider.overrideWithValue(HiveTodosRepository())], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App Using Riverpod',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TodoPage(),
    );
  }
}
