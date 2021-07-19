import 'package:acceptwire/logic/fetch_balance/fetch_balance_bloc.dart';
import 'package:acceptwire/repository/profile_repository.dart';
import 'package:acceptwire/utils/helpers/helpers.dart';
import 'package:acceptwire/utils/helpers/text.dart';
import 'package:acceptwire/utils/widgets/loading.dart';
import 'package:acceptwire/utils/widgets/snackbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';

class AccountBalance extends StatelessWidget {
  late final FetchBalanceBloc _bloc;

  @override
  Widget build(BuildContext buildContext) {
    ProfileRepository _profileRepo = buildContext.read<ProfileRepository>();
    _bloc = FetchBalanceBloc(repository: _profileRepo);

    displayBalance(double balance, bool loading) {
      return FocusDetector(
        onVisibilityGained: () async => await _bloc.fetchBalance(),
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
          (_) => null,
          (_) => null,
          (loaded) =>
              {mSnackBar(context: buildContext, message: 'Balance updated')},
        );
      },
      builder: (context, state) {
        return Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(12),
              child: state.join(
                  (initial) => displayBalance(0.0, false),
                  (loading) => displayBalance(0.0, true),
                  (loaded) =>
                      displayBalance(loaded.profilePODO.mainBalance, false)),
            ));
      },
    );
  }
}
