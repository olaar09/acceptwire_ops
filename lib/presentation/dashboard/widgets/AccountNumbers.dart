import 'package:acceptwire/podo/bank_account_podo.dart';
import 'package:acceptwire/utils/helpers/text.dart';
import 'package:acceptwire/utils/widgets/error.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountNumbers extends StatelessWidget {
  final List<BankAccountPODO>? bankAccounts;

  const AccountNumbers({
    this.bankAccounts,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(bankAccounts);
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
                  ],
                ),
              ),
              Container(
                height: 110,
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...bankAccounts!
                        .map((bankAccount) => buildAccountItem(
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
      {required bankName, required accountNumber, required reflectionTime}) {
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
                child: Text('acc'),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  regularText('$bankName', size: 16),
                  boldText('$accountNumber'),
                  Row(
                    children: [
                      regularText(
                          'Transactions reflect in < $reflectionTime minute',
                          size: 12),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
