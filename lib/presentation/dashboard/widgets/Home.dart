import 'package:acceptwire/podo/profile_podo.dart';
import 'package:acceptwire/presentation/dashboard/widgets/AccountBalance.dart';
import 'package:acceptwire/presentation/dashboard/widgets/AccountNumbers.dart';
import 'package:acceptwire/presentation/dashboard/widgets/LatestTransactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final ProfilePODO profilePODO;

  Home({required this.profilePODO});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext buildContext) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AccountBalance(),
        AccountNumbers(
          bankAccounts: widget.profilePODO.bankAccounts,
        ),
        LatestTransactions()
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
