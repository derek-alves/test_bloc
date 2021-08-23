import 'dart:async';

import 'package:bloc/bloc.dart';
import './sort_numbers_event.dart';
import './sort_numbers_state.dart';

class SortNumbersBloc extends Bloc<SortNumbersEvent, SortNumbersState> {
  SortNumbersBloc() : super(SortNumbersInitial());

  @override
  Stream<SortNumbersState> mapEventToState(SortNumbersEvent event) async* {
    yield const SortNumbersLoading();

    if (event is SortNumberResetEvent) {
      yield SortNumbersInitial();
    }

    if (event is SortNumberInsertEvent) {
      if (event.data!.isEmpty) {
        yield const SortNumbersError("Lista vazia");
      } else {
        final filterValues = event.data!.toSet().toList();
        filterValues.sort((a, b) => int.parse(a).compareTo(int.parse(b)));

        yield SortNumbersSuccess(List.of(filterValues));
        print("yielding");
      }
    }
  }

  void dispose() {}
}
