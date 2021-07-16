import 'package:acceptwire/podo/lecture_podo.dart';

abstract class LibraryState {}

class LibraryLoadingState extends LibraryState {}

class LibraryLoadedState extends LibraryState {
  final Lecture lecture;

  LibraryLoadedState({required this.lecture});
}

class LibrariesLoadedState extends LibraryState {
  final List<Lecture> lectures;

  LibrariesLoadedState({required this.lectures});
}

class LibraryErrorState extends LibraryState {
  final String message;

  LibraryErrorState({required this.message});
}
