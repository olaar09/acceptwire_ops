import 'package:acceptwire/utils/helpers/helpers.dart';
import 'package:equatable/equatable.dart';

class TransactionPODO extends Equatable {
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
      amount: double.parse('${map['amount']}'),
      bankLogo: map.containsKey('bankLogo') ? map['bankLogo'] : '',
      bankId: map.containsKey('bankId') ? map['bankId'] : '',
      bankName: map.containsKey('bankName') ? map['bankName'] : '',
      date: map.containsKey('timestamp')
          ? getTimeObj('${map['timestamp']}')
          : DateTime.now(),
      receiptSent: map.containsKey('receiptSent') ? map['receiptSent'] : false,
      touched: map.containsKey('touched') ? map['touched'] : false,
    );
  }

  List<TransactionPODO> fromJsonArr(List list) {
    return List<TransactionPODO>.from(
        list.map((x) => TransactionPODO.fromJson(x)));
  }

  @override
  // TODO: implement props
  List<Object?> get props => [date, amount, bankName, bankLogo];
}
