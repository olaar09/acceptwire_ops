import 'package:acceptwire/logic/transactions/transactions_bloc.dart';
import 'package:acceptwire/podo/transaction_podo.dart';
import 'package:acceptwire/presentation/dashboard/widgets/SendReceipt.dart';
import 'package:acceptwire/presentation/dashboard/widgets/ViewTransaction.dart';
import 'package:acceptwire/utils/helpers/get_value.dart';
import 'package:acceptwire/utils/helpers/helpers.dart';
import 'package:acceptwire/utils/helpers/text.dart';
import 'package:acceptwire/utils/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

openReceiptModal(
    BuildContext buildContext, TransactionPODO transaction, receiptSentTemp) {
  showCupertinoModalBottomSheet(
      context: buildContext,
      builder: (context) => SendReceipt(
            receiptSentTemp: receiptSentTemp,
            transactionPODO: transaction,
          ),
      barrierColor: Colors.grey[100]);
}

openViewTrxModal(BuildContext buildContext, TransactionPODO transaction) {
  showCupertinoModalBottomSheet(
      context: buildContext,
      builder: (context) => ViewTransaction(
            transactionPODO: transaction,
          ),
      barrierColor: Colors.grey[100]);
}

class LatestTransactions extends StatelessWidget {
  late final TransactionBloc _bloc;
  final List<String> receiptSentTemp = [];

  @override
  Widget build(BuildContext buildContext) {
    _bloc = buildContext.read<TransactionBloc>();
    _bloc.init();

    return Expanded(
        flex: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Expanded(
              child: BlocConsumer<TransactionBloc, TransactionState>(
                bloc: _bloc,
                listener: (context, state) {
                  print('transactions state changes');
                },
                builder: (context, state) {
                  return buildCustomScrollView(state);
                },
              ),
            ),
          ],
        ));
  }

  Widget buildCustomScrollView(TransactionState state) {
    return state.join(
      (init) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: networkActivityIndicator()),
          regularText('Waiting to receive your transfers'),
        ],
      ),
      (loaded) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(),
          Expanded(
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                CupertinoSliverRefreshControl(
                  onRefresh: () async {
                    await Future.delayed(Duration(seconds: 3));
                  },
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return buildTransactionItem(
                        loaded.transactions[index], context);
                  }, childCount: loaded.transactions.length),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTransactionItem(TransactionPODO transaction, context) {
    return Container(
      child: Column(
        children: [
          Container(
            color: transaction.markedAppendedTrx
                ? Colors.orange[100]
                : Colors.transparent,
            padding: EdgeInsets.all(8.0),
            height: 80,
            child: Row(
              children: [
                buildCircleAvatar(transaction.bankLogo),
                SizedBox(width: 10),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildAmountColumn(transaction),
                      buildActionsColumn(transaction, context)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 0,
            height: 1.2,
          )
        ],
      ),
    );
  }

  Column buildActionsColumn(TransactionPODO transaction, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(6.0, 0, 0, 0),
            child: regularText('${formatDateTime(transaction.date)}', size: 14),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 30,
                child: IconButton(
                    onPressed: () {
                      openReceiptModal(context, transaction, receiptSentTemp);
                      print('send receipts');
                    },
                    icon: Icon(Icons.receipt_long_sharp,
                        color: Vl.color(color: MColor.K_SECONDARY_TEXT))),
              ),
              Container(
                height: 30,
                width: 30,
                child: IconButton(
                    onPressed: () {
                      openViewTrxModal(context, transaction);
                    },
                    icon: Icon(
                      Icons.more_horiz_rounded,
                      color: Vl.color(color: MColor.K_SECONDARY_TEXT),
                    )),
              )
            ],
          ),
        )
      ],
    );
  }

  Column buildAmountColumn(TransactionPODO transaction) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boldText(formatMoney(transaction.amount), size: 16),
        regularText('${transaction.customerName}', size: 15, maxLines: 1),
      ],
    );
  }

  CircleAvatar buildCircleAvatar(String image) {
    String dummyImage =
        'https://awire-assets.s3.eu-central-1.amazonaws.com/bank.png';
    return CircleAvatar(
      backgroundColor: Colors.white,
      backgroundImage: NetworkImage('${image.length < 1 ? dummyImage : image}'),
      radius: 16,
    );
  }

  Padding header() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: regularText('Latest transactions'),
    );
  }
}
