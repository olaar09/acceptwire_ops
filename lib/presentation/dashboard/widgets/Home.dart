import 'package:acceptwire/logic/fetch_balance/fetch_balance_bloc.dart';
import 'package:acceptwire/presentation/dashboard/widgets/AccountBalance.dart';
import 'package:acceptwire/presentation/dashboard/widgets/AccountNumbers.dart';
import 'package:acceptwire/presentation/dashboard/widgets/LatestTransactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext buildContext) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [AccountBalance(), AccountNumbers(), LatestTransactions()],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
