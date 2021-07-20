import 'package:acceptwire/logic/fetch_balance/fetch_balance_bloc.dart';
import 'package:acceptwire/logic/transactions/transactions_bloc.dart';
import 'package:acceptwire/podo/profile_podo.dart';
import 'package:acceptwire/presentation/dashboard/widgets/AccountBalance.dart';
import 'package:acceptwire/presentation/dashboard/widgets/AccountNumbers.dart';
import 'package:acceptwire/presentation/dashboard/widgets/LatestTransactions.dart';
import 'package:acceptwire/repository/auth_repository.dart';
import 'package:acceptwire/repository/profile_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:acceptwire/logic/fetch_balance/fetch_balance_bloc.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  final ProfilePODO profilePODO;

  Home({required this.profilePODO});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late  TransactionBloc _trxBloc;

  @override
  Widget build(BuildContext buildContext) {
    ProfileRepository _profileRepo = buildContext.read<ProfileRepository>();
    AuthRepository _authRepo = buildContext.read<AuthRepository>();
    //  if (GetUtils.isNullOrBlank(_trxBloc) ?? true) {
    _trxBloc = TransactionBloc(authRepository: _authRepo);
    // }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocProvider(
          create: (context) => FetchBalanceBloc(
            repository: _profileRepo,
            transactionBloc: _trxBloc,
          ),
          child: AccountBalance(),
        ),
        AccountNumbers(
          bankAccounts: widget.profilePODO.bankAccounts,
        ),
        BlocProvider.value(
          value: _trxBloc,
          child: LatestTransactions(),
        )
      ],
    );
  }

  @override
  void dispose() {
    _trxBloc.close();
    super.dispose();
  }
}
