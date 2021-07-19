import 'package:acceptwire/utils/helpers/helpers.dart';

class TransactionPODO {
  late double amount;
  late DateTime date;
  late String bankId;
  late String bankLogo;
  late bool receiptSent;
  late bool touched;
  late String bankName;

  TransactionPODO();

  TransactionPODO.setData({
    required this.amount,
    required this.bankLogo,
    required this.bankName,
    required this.bankId,
    required this.date,
    required this.receiptSent,
    required this.touched,
  });

  factory TransactionPODO.fromJson(Map<dynamic, dynamic> map) {
    return TransactionPODO.setData(
      amount: map['amount'],
      bankLogo: map['bankLogo'],
      bankId: map['bankName'],
      bankName: map['bankId'],
      date: getTimeObj('${map['date']}'),
      receiptSent: map['receiptSent'],
      touched: map['touched'],
    );
  }

  List<TransactionPODO> fromJsonArr(List list) {
    return List<TransactionPODO>.from(
        list.map((x) => TransactionPODO.fromJson(x)));
  }
}
