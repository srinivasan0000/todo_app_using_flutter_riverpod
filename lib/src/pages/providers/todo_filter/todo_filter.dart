import '../../../models/todo_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'todo_filter.g.dart';

@riverpod
class TodoFilter extends _$TodoFilter {
  @override
  Filter build() {
    return Filter.all;
    
  }

  void changeFilter(Filter newFilter) {
    state = newFilter;
  }
}
