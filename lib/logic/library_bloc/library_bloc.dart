import 'package:acceptwire/podo/lecture_podo.dart';
import 'package:acceptwire/repository/auth_repository.dart';
import 'package:acceptwire/repository/library_repository.dart';
import 'package:acceptwire/logic/library_bloc/bloc.dart';
import 'package:acceptwire/utils/helpers/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  LibraryRepo libraryRepo;
  late List<Lecture> holdingLectures = [];

  // AuthRepository authRepository;

  LibraryBloc({required this.libraryRepo}) : super(LibraryLoadingState());

  @override
  Stream<LibraryState> mapEventToState(LibraryEvent event) async* {
    yield LibraryLoadingState();

    if (event is LibrarySearchEvent) {
      try {
        List<Lecture> lectures = onLibraryCountrySearch(event.searchTerm);
        yield LibrariesLoadedState(lectures: lectures);
      } catch (e) {
        LibraryErrorState(message: 'An error occurred while fetching lectures');
      }
    }

    if (event is LibrariesLoadingEvent) {
      try {
        List<Lecture> lectures = await libraryRepo.getLectures();
        setHoldingLectures(lectures);
        yield LibrariesLoadedState(lectures: lectures);
      } on DioError catch (e) {
        if (e.error is RequestResponse) {
          yield LibraryErrorState(message: '${e.error.reason}');
        } else {
          yield LibraryErrorState(message: '${e.message}');
        }
      } catch (e) {
        yield LibraryErrorState(
            message: 'An error occurred while fetching lectures');
      }
    }

    if (event is LibraryLoadingEvent) {
      libraryRepo.getLecture(lectureId: event.lectureId);
    }
  }

  onLibraryCountrySearch(String query) {
    return holdingLectures
        .where((Lecture element) =>
            element.title!.contains(new RegExp(query, caseSensitive: false)))
        .toList();
  }

  void setHoldingLectures(lectures) {
    holdingLectures = lectures;
  }

  void fireAllLoadingEvent() {
    this.add(LibrariesLoadingEvent());
  }

  void fireSearchEvent(String search) {
    this.add(LibrarySearchEvent(searchTerm: search));
  }
}
