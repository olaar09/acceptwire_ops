import 'package:acceptwire/repository/receipt_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:sealed_unions/sealed_unions.dart';

part 'send_receipt_state.dart';

class SendReceiptBloc extends Cubit<SendReceiptState> {
  Dio _restClient;
  late ReceiptRepo _receiptRepo;

  SendReceiptBloc({required Dio client})
      : _restClient = client,
        super(SendReceiptState.initial()) {
    _receiptRepo = ReceiptRepo(restClient: _restClient);
  }

  doSendReceipt({
    required String customerPhone,
    required String purchaseDescription,
  }) async {
    this.emit(SendReceiptState.loading());

    if (GetUtils.isNullOrBlank(customerPhone) ?? true) {
      this.emit(SendReceiptState.validationErr(
        phoneErr: 'Enter phone number',
        purchaseItemErr: '',
      ));
      return;
    }

    if (GetUtils.isNullOrBlank(purchaseDescription) ?? true) {
      this.emit(SendReceiptState.validationErr(
        phoneErr: '',
        purchaseItemErr: 'Enter purchase description',
      ));
      return;
    }

    var response = await _receiptRepo.sendReceipt(
      customerPhone: customerPhone,
      purchaseDescription: purchaseDescription,
    );

    if (response is bool) {
      this.emit(SendReceiptState.loaded());
    } else {
      this.emit(SendReceiptState.networkErr(message: response));
    }
  }
}
