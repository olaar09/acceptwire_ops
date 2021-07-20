import 'package:acceptwire/exceptions/RequestResponseException.dart';
import 'package:acceptwire/utils/helpers/rest_client.dart';
import 'package:dio/dio.dart';

class ReceiptRepo {
  late Dio restClient;

  ReceiptRepo({required this.restClient});

  sendReceipt(
      {required String transactionId,
      required String customerPhone,
      required String purchaseDescription}) async {
    /// try to send receipt
    try {
      final response = await this.restClient.post('/merchant/receipt', data: {
        'customerPhone': customerPhone,
        'purchaseDescription': purchaseDescription,
        'transactionId': transactionId
      });
      RequestResponse requestResponse = response.data;
      if (requestResponse.statusCode == RequestResponse.STATUS_OK) {
        return true;
      }
      throw RequestResponseException(cause: 'Request could not complete');
    } on DioError catch (e) {
      return e.error.reason;
    } catch (e) {
      return e.toString();
    }
  }
}
