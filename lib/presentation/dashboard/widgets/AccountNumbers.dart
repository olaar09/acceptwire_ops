import 'package:acceptwire/logic/reflection_meter/reflection_meter_bloc.dart';
import 'package:acceptwire/logic/reflection_meter/reflection_meter_bloc.dart';
import 'package:acceptwire/podo/bank_account_podo.dart';
import 'package:acceptwire/utils/helpers/text.dart';
import 'package:acceptwire/utils/widgets/error.dart';
import 'package:acceptwire/utils/widgets/loading.dart';
import 'package:acceptwire/utils/widgets/snackbars.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AccountNumbers extends StatelessWidget {
  final List<BankAccountPODO>? bankAccounts;
  final ReflectionMeterBloc _bloc = ReflectionMeterBloc();

  AccountNumbers({
    this.bankAccounts,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetUtils.isNullOrBlank(bankAccounts) ?? true
        ? emptyState()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    regularText('Account numbers'),
                    BlocConsumer<ReflectionMeterBloc, ReflectionMeterState>(
                      bloc: _bloc,
                      listener: (context, state) {
                        mSnackBar(
                            context: context,
                            message: 'Transaction speed status updated');
                      },
                      builder: (context, state) {
                        return state.join(
                            (loaded) => Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.downloading_outlined,
                                      size: 18,
                                      color: loaded.status == 'ok'
                                          ? Colors.green[400]
                                          : Colors.red,
                                    ),
                                    SizedBox(width: 4),
                                    Expanded(
                                        child: regularText('${loaded.reading}',
                                            size: 12)),
                                  ],
                                ),
                            () => networkActivityIndicator(radius: 14));
                      },
                    )
                  ],
                ),
              ),
              Container(
                height: 90,
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...bankAccounts!
                        .map((bankAccount) => buildAccountItem(
                            bankLogo: '${bankAccount.bankLogo}',
                            bankName: '${bankAccount.bankName}',
                            accountNumber: '${bankAccount.accountNumber}',
                            reflectionTime: '1'))
                        .toList(),
                  ],
                ),
              ),
            ],
          );
  }

  Container buildAccountItem(
      {required bankName,
      required bankLogo,
      required accountNumber,
      required reflectionTime}) {
    print(bankLogo);
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: DottedBorder(
        color: Colors.grey,
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        padding: EdgeInsets.all(6),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('$bankLogo'),
                backgroundColor: Colors.white,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  regularText('$bankName', size: 16),
                  boldText('$accountNumber'),
                  /* Row(
                    children: [
                      regularText(
                          'Transactions reflect in < $reflectionTime minute',
                          size: 12),
                    ],
                  )*/
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
