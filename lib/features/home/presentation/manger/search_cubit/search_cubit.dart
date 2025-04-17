// lib/cubit/search_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<String> {
  SearchCubit() : super('');

  void submitSearch(String query) {
    emit(query);
  }

  void clearSearch() {
    emit('');
  }
}
