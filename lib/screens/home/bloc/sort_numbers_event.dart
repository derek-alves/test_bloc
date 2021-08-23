abstract class SortNumbersEvent {}

class SortNumberInsertEvent extends SortNumbersEvent {
  final List? data;

  SortNumberInsertEvent({
    this.data,
  });
}

class SortNumberResetEvent extends SortNumbersEvent {}
