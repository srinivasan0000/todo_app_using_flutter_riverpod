
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'todo_theme.g.dart';

@riverpod
class TodoTheme extends _$TodoTheme {
  @override
  ThemeState build() {
    return ThemeState.light;
  }

  void changeTheme() {
    state = state == ThemeState.light ? ThemeState.dark : ThemeState.light;
  }
}

enum ThemeState { light, dark }
