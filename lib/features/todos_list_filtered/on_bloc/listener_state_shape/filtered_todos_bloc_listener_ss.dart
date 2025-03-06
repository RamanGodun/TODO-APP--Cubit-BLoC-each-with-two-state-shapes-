import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/models/todo_model.dart';

part 'filtered_todos_event.dart';
part 'filtered_todos_state.dart';

class FilteredTodosBlocWithListenerStateShape extends Bloc<
    FilteredTodosEventWithListenerStateShape,
    FilteredTodosStateOnBlocWithListenerStateShape> {
  final List<Todo> initialTodos;

  FilteredTodosBlocWithListenerStateShape({
    required this.initialTodos,
  }) : super(FilteredTodosStateOnBlocWithListenerStateShape(
            filteredTodos: initialTodos)) {
    on<CalculateFilteredTodosEventWithListenerStateShape>((event, emit) {
      emit(state.copyWith(filteredTodos: event.filteredTodos));
    });
  }
}
