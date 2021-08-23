import 'package:equatable/equatable.dart';

abstract class SortNumbersState extends Equatable {
  const SortNumbersState();

  @override
  List<Object> get props => [];
}

class SortNumbersInitial extends SortNumbersState {
  @override
  List<Object> get props => [];
}

class SortNumbersSuccess extends SortNumbersState {
  final List data;

  const SortNumbersSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class SortNumbersLoading extends SortNumbersState {
  const SortNumbersLoading();
}

class SortNumbersError extends SortNumbersState {
  final String message;

  const SortNumbersError(this.message);
}
