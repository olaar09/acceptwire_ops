import 'package:acceptwire/logic/fetch_balance/fetch_balance_bloc.dart';
import 'package:acceptwire/utils/helpers/helpers.dart';
import 'package:acceptwire/utils/helpers/text.dart';
import 'package:acceptwire/utils/widgets/loading.dart';
import 'package:acceptwire/utils/widgets/snackbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';

class AccountBalance extends StatelessWidget {
  late final FetchBalanceBloc _bloc;

  @override
  Widget build(BuildContext buildContext) {
    _bloc = buildContext.read<FetchBalanceBloc>();

    displayBalance(double balance, bool loading,
        {required FetchBalanceState state}) {
      return FocusDetector(
        onVisibilityGained: () async {
          // load if not already loaded.
          state.join(
            (initial) async => await _bloc.fetchBalance(),
            (_) => null,
            (_) => null,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                regularText('Main balance'),
                loading
                    ? Container(
                        margin: const EdgeInsets.fromLTRB(16.0, 10.0, 0, 0),
                        child: networkActivityIndicator(radius: 10),
                      )
                    : Container(
                        height: 25,
                        child: IconButton(
                          iconSize: 20,
                          onPressed: () {
                            _bloc.fetchBalance();
                          },
                          icon: Icon(Icons.refresh),
                        ),
                      )
              ],
            ),
            boldText('${formatMoney(balance)}', size: 22)
          ],
        ),
      );
    }

    return BlocConsumer<FetchBalanceBloc, FetchBalanceState>(
      bloc: _bloc,
      listener: (context, state) {
        state.join(
          (initial) {
            if (GetUtils.isNullOrBlank(initial.error) ?? true) return;
            mSnackBar(context: buildContext, message: '${initial.error}');
          },
          (_) => null,
          (loaded) =>
              mSnackBar(context: buildContext, message: 'Balance updated'),
        );
      },
      builder: (context, state) {
        return Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(12),
              child: state.join(
                  (initial) => displayBalance(0.0, false, state: state),
                  (loading) => displayBalance(0.0, true, state: state),
                  (loaded) => displayBalance(
                      loaded.profilePODO.mainBalance, false,
                      state: state)),
            ));
      },
    );
  }
}
