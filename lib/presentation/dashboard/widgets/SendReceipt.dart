import 'package:acceptwire/logic/send_receipt/send_receipt_bloc.dart';
import 'package:acceptwire/podo/transaction_podo.dart';
import 'package:acceptwire/utils/helpers/helpers.dart';
import 'package:acceptwire/utils/helpers/rest_client.dart';
import 'package:acceptwire/utils/helpers/text.dart';
import 'package:acceptwire/utils/widgets/error.dart';
import 'package:acceptwire/utils/widgets/loading.dart';
import 'package:acceptwire/utils/widgets/snackbars.dart';
import 'package:acceptwire/utils/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendReceipt extends StatefulWidget {
  late final TransactionPODO transactionPODO;

  SendReceipt({
    required this.transactionPODO,
    Key? key,
  }) : super(key: key);

  @override
  _SendReceiptState createState() => _SendReceiptState();
}

class _SendReceiptState extends State<SendReceipt> {
  late SendReceiptBloc _bloc;
  final _phoneTextController = TextEditingController();
  final _itemTextController = TextEditingController();

  @override
  Widget build(BuildContext buildContext) {
    Dio _restClient = buildContext.read<Dio>();
    _bloc = SendReceiptBloc(client: _restClient);
    //print(_restClient);

    return Material(
      child: Container(
        height: 480,
        padding: EdgeInsets.fromLTRB(10, 18, 10, 0),
        child: BlocConsumer<SendReceiptBloc, SendReceiptState>(
          bloc: _bloc,
          listener: (context, state) {
            state.join(
              (_) => buildSendButton(),
              (_) => networkActivityIndicator(),
              (_) => emptyState(),
              (_) => buildSendButton(),
              (networkErr) => mSnackBar(
                context: buildContext,
                message: '$networkErr.message',
              ),
            );
          },
          builder: (context, state) {
            return ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    boldText('Send receipt'),
                    state.join(
                      (_) => buildSendButton(),
                      (_) => networkActivityIndicator(),
                      (_) => emptyState(),
                      (_) => buildSendButton(),
                      (_) => buildSendButton(),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  regularText('${widget.transactionPODO.customerName}',
                      size: 16),
                  regularText('Customer name', size: 14),
                ]),
                SizedBox(height: 20),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  regularText(formatMoney(widget.transactionPODO.amount),
                      size: 16),
                  regularText('Transaction amount', size: 14),
                ]),
                SizedBox(height: 2),
                mTextField('Customer phone number',
                    onChanged: (text) {},
                    controller: _phoneTextController,
                    error: state.join(
                      (_) => '',
                      (_) => '',
                      (_) => '',
                      (validationErr) => '${validationErr.phoneErr}',
                      (_) => '',
                    )),
                mTextField('What did you sell? ',
                    onChanged: (text) {},
                    controller: _itemTextController,
                    error: state.join(
                      (_) => '',
                      (_) => '',
                      (_) => '',
                      (validationErr) => '${validationErr.purchaseItemErr}',
                      (_) => '',
                    ))
              ],
            );
          },
        ),
      ),
    );
  }

  IconButton buildSendButton() {
    return IconButton(
      icon: Icon(Icons.send),
      onPressed: () {
        _bloc.doSendReceipt(
          customerPhone: _phoneTextController.text,
          purchaseDescription: _itemTextController.text,
        );
      },
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
