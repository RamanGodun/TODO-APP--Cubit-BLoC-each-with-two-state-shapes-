import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app_settings_on_cubit/app_settings_cubit.dart';
import '../models/todo_model.dart';
import '../utils/bloc_exports.dart';
import '../utils/cubits_export.dart';

/// 🏭 [SearchAndFilterTodoFactory] динамічно повертає потрібний [SearchAndFilterTodoManager]
/// в залежності від значення [isUsingBlocForAppFeatures] з [AppSettingsCubit].
class SearchAndFilterTodoFactory {
  static SearchAndFilterTodoManager create(BuildContext context) {
    final isUsingBlocForAppFeatures =
        context.read<AppSettingsCubit>().state.isUsingBlocForAppFeatures;

    return isUsingBlocForAppFeatures
        ? BlocSearchAndFilterTodoManager(context)
        : CubitSearchAndFilterTodoManager(context);
  }
}

/// 🔢 [SearchAndFilterTodoManager] визначає абстрактний інтерфейс для управління пошуком та фільтрацією [TODO].
/// Підтримує як BLoC, так і Cubit стратегії управління станом.
abstract class SearchAndFilterTodoManager {
  void setSearchTerm(String searchTerm);
  void changeFilter(Filter filter);
  Filter get currentFilter;
}

/// 🚦 BLoC реалізація [SearchAndFilterTodoManager].
class BlocSearchAndFilterTodoManager implements SearchAndFilterTodoManager {
  final BuildContext _context;

  BlocSearchAndFilterTodoManager(this._context);

  @override
  void setSearchTerm(String searchTerm) {
    _context
        .read<TodoSearchBloc>()
        .add(SetSearchTermEvent(newSearchTerm: searchTerm));
  }

  @override
  void changeFilter(Filter filter) {
    _context.read<TodoFilterBloc>().add(ChangeFilterEvent(newFilter: filter));
  }

  @override
  Filter get currentFilter => _context.watch<TodoFilterBloc>().state.filter;
}

/// 🚦 Cubit реалізація [SearchAndFilterTodoManager].
class CubitSearchAndFilterTodoManager implements SearchAndFilterTodoManager {
  final BuildContext _context;

  CubitSearchAndFilterTodoManager(this._context);

  @override
  void setSearchTerm(String searchTerm) {
    _context.read<TodoSearchCubit>().setSearchTerm(searchTerm);
  }

  @override
  void changeFilter(Filter filter) {
    _context.read<TodoFilterCubit>().changeFilter(filter);
  }

  @override
  Filter get currentFilter => _context.watch<TodoFilterCubit>().state.filter;
}
