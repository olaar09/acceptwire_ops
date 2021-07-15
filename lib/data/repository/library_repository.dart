import 'package:acceptwire/data/podo/lecture_podo.dart';
import 'package:acceptwire/utils/helpers/rest_client.dart';
import 'package:dio/dio.dart';

class LibraryRepo {
  late Dio restClient;

  LibraryRepo({required this.restClient});

  getLectures() async {
    final response = await this.restClient.get('/lectures');

    RequestResponse requestResponse = response.data;
    if (requestResponse.status == RequestResponse.STATUS_SUCCESS)
      return Lecture().fromJsonArr(requestResponse.data);

    return requestResponse.reason;
  }

  getLecture({int lectureId = 1}) {
    print('getting lecture');
  }

  favLecture({int classId = 1}) {
    print('faving lectures');
  }

  downloadLecture({int classId = 1}) {
    print('downloading lectures');
  }
}
