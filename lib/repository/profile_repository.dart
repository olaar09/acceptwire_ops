import 'package:acceptwire/exceptions/RequestResponseException.dart';
import 'package:acceptwire/podo/profile_podo.dart';
import 'package:acceptwire/repository/auth_repository.dart';
import 'package:acceptwire/utils/helpers/rest_client.dart';
import 'package:dio/dio.dart';

class ProfileRepository {
  final Dio _restClient;

  ProfileRepository({required Dio restClient}) : _restClient = restClient;

  Future getProfile() async {
    try {
      Response response = await _restClient.get('/merchant');

      RequestResponse parseResponse = response.data;
      if (parseResponse.statusCode == RequestResponse.STATUS_OK) {
        return ProfilePODO.fromJson(parseResponse.data);
      }
      throw RequestResponseException(cause: 'Error ${parseResponse.reason}');
    } on DioError catch (e) {
      return e.error.reason;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future attemptVerification({firstName, lastName, bvn}) async {
    try {
      Response response = await _restClient.put('/merchant',
          data: {'lastName': lastName, 'firstName': firstName, 'bvn': bvn});

      RequestResponse parseResponse = response.data;
      return ProfilePODO.fromJson(parseResponse.data);
    } on DioError catch (e) {
      return e.error.reason;
    } catch (e) {
      return e.toString();
    }
  }

  Future createProfileAfterSignUp({required phoneNumber}) async {
    try {
      Response response = await _restClient.post(
        '/merchant',
        data: {'type': 'phoneData', 'Phone': phoneNumber},
      );

      RequestResponse parseResponse = response.data;
      return ProfilePODO.fromJson(parseResponse.data);
    } on DioError catch (e) {
      return e.error.reason;
    } catch (e) {
      return e.toString();
    }
  }
}
