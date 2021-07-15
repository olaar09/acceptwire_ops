import 'package:acceptwire/data/podo/lecture_podo.dart';

abstract class LibraryEvent {}

class LibraryLoadingEvent extends LibraryEvent {
  int lectureId;

  LibraryLoadingEvent({required this.lectureId});
}

class LibrarySearchEvent extends LibraryEvent {
  String searchTerm;

  LibrarySearchEvent({required this.searchTerm});
}

class LibrariesLoadingEvent extends LibraryEvent {}

class LibraryLoadedEvent extends LibraryEvent {}

class LibraryErrorEvent extends LibraryEvent {}
