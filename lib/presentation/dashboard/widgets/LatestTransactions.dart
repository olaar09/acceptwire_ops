import 'package:acceptwire/logic/transactions/transactions_bloc.dart';
import 'package:acceptwire/podo/transaction_podo.dart';
import 'package:acceptwire/repository/auth_repository.dart';
import 'package:acceptwire/utils/helpers/get_value.dart';
import 'package:acceptwire/utils/helpers/helpers.dart';
import 'package:acceptwire/utils/helpers/text.dart';
import 'package:acceptwire/utils/widgets/loading.dart';
import 'package:acceptwire/utils/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

openReceiptModal(BuildContext buildContext) {
  showCupertinoModalBottomSheet(
      context: buildContext,
      builder: (context) => Material(
            child: Container(
              height: 480,
              padding: EdgeInsets.fromLTRB(10, 18, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      boldText('Send receipt'),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          print('');
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        regularText('Agboola Yusuf', size: 16),
                        regularText('Customer name', size: 14),
                      ]),
                  SizedBox(height: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        regularText(formatMoney(20000), size: 16),
                        regularText('Transaction amount', size: 14),
                      ]),
                  SizedBox(height: 2),
                  mTextField('Customer phone number'),
                  mTextField('What did you sell? ')
                ],
              ),
            ),
          ),
      barrierColor: Colors.grey[100]);
}

openViewTrxModal(BuildContext buildContext) {
  showCupertinoModalBottomSheet(
      context: buildContext,
      builder: (context) => Material(
            child: Container(
              height: 420,
              padding: EdgeInsets.fromLTRB(10, 18, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      boldText('Transaction details'),
                      IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          print('');
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(children: [
                    CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://awire-assets.s3.eu-central-1.amazonaws.com/access_Bank_Logo.png')),
                  ]),
                  SizedBox(height: 30),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        boldText(formatMoney(20000)),
                        regularText('Transaction amount', size: 14),
                      ]),
                  SizedBox(height: 30),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        boldText('Agboola Yusuf'),
                        regularText('Customer name', size: 14),
                      ]),
                  SizedBox(height: 30),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        boldText('2020-06-20'),
                        regularText('Transaction date', size: 14),
                      ]),
                ],
              ),
            ),
          ),
      barrierColor: Colors.grey[100]);
}

class LatestTransactions extends StatelessWidget {
  late final TransactionBloc _bloc;

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
          Divider()
        ],
      ),
    );
  }

  Column buildActionsColumn(TransactionPODO transaction, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(6.0, 0, 0, 0),
          child: regularText('${formatDateTime(transaction.date)}', size: 14),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 30,
              child: IconButton(
                  onPressed: () {
                    openReceiptModal(context);
                    print('send receipts');
                  },
                  icon: Icon(Icons.receipt_long_sharp,
                      color: Vl.color(color: MColor.K_SECONDARY_TEXT))),
            ),
            Container(
              height: 30,
              child: IconButton(
                  onPressed: () {
                    openViewTrxModal(context);
                  },
                  icon: Icon(
                    Icons.more_horiz_rounded,
                    color: Vl.color(color: MColor.K_SECONDARY_TEXT),
                  )),
            )
          ],
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
    return CircleAvatar(
      backgroundColor: Colors.white,
      backgroundImage: NetworkImage('$image'),
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
