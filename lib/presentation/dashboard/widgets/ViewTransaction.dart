import 'package:acceptwire/podo/transaction_podo.dart';
import 'package:acceptwire/utils/helpers/helpers.dart';
import 'package:acceptwire/utils/helpers/navigation.dart';
import 'package:acceptwire/utils/helpers/text.dart';
import 'package:flutter/material.dart';

class ViewTransaction extends StatelessWidget {
  final TransactionPODO transactionPODO;

  const ViewTransaction({
    required this.transactionPODO,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
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
                  icon: Icon(Icons.close),
                  onPressed: () {
                    navToBack(context: context, data: null);
                  },
                )
              ],
            ),
            SizedBox(height: 10),
            Row(children: [
              CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage('${transactionPODO.bankLogo}')),
            ]),
            SizedBox(height: 30),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              boldText(formatMoney(transactionPODO.amount)),
              regularText('Transaction amount', size: 14),
            ]),
            SizedBox(height: 30),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              boldText('${transactionPODO.customerName}'),
              regularText('Customer name', size: 14),
            ]),
            SizedBox(height: 30),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              boldText('${formatDateTime(transactionPODO.date)}'),
              regularText('Transaction date', size: 14),
            ]),
          ],
        ),
      ),
    );
  }
}
