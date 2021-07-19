import 'package:acceptwire/logic/auth_bloc/auth_bloc.dart';
import 'package:acceptwire/logic/transactions/transactions_bloc.dart';
import 'package:acceptwire/podo/transaction_podo.dart';
import 'package:acceptwire/repository/auth_repository.dart';
import 'package:acceptwire/utils/helpers/get_value.dart';
import 'package:acceptwire/utils/helpers/helpers.dart';
import 'package:acceptwire/utils/helpers/text.dart';
import 'package:acceptwire/utils/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// openModal(){
//   showCupertinoModalBottomSheet(
//     context: context,
//     builder: (context) => Container(),
//   );
// }

class LatestTransactions extends StatelessWidget {
  late final TransactionBloc _bloc;

  @override
  Widget build(BuildContext buildContext) {
    AuthRepository _authRepo = buildContext.read<AuthRepository>();
    _bloc = TransactionBloc(authRepository: _authRepo);
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
                    return buildTransactionItem(loaded.transactions[index]);
                  }, childCount: loaded.transactions.length),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTransactionItem(TransactionPODO transaction) {
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
                      buildActionsColumn(transaction)
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

  Column buildActionsColumn(TransactionPODO transaction) {
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
                    print('send receipts');
                  },
                  icon: Icon(Icons.receipt_long_sharp,
                      color: Vl.color(color: MColor.K_SECONDARY_TEXT))),
            ),
            Container(
              height: 30,
              child: IconButton(
                  onPressed: () {
                    print('view transaction');
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
        boldText(formatMoney(transaction.amount)),
        regularText('${transaction.bankName}', size: 14),
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
