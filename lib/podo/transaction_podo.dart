import 'package:acceptwire/utils/helpers/helpers.dart';
import 'package:equatable/equatable.dart';

class TransactionPODO extends Equatable {
  late final double amount;
  late final DateTime date;
  late final String bankId;
  late final String bankLogo;
  late final bool receiptSent;
  late final bool touched;
  late final String bankName;
  late final String transactionId;
  late final String customerName;
  late final bool markedAppendedTrx;

  TransactionPODO();

  TransactionPODO.setData(
      {required this.amount,
      required this.bankLogo,
      required this.bankName,
      required this.bankId,
      required this.date,
      required this.transactionId,
      required this.receiptSent,
      required this.touched,
      required this.customerName,
      required this.markedAppendedTrx});

  factory TransactionPODO.fromJson(Map<dynamic, dynamic> map) {
    return TransactionPODO.setData(
        amount: double.parse('${map['amount']}'),
        bankLogo: map.containsKey('bankLogo') ? map['bankLogo'] : '',
        bankId: map.containsKey('bankId') ? map['bankId'] : '',
        bankName: map.containsKey('bankName') ? map['bankName'] : '',
        transactionId: map.containsKey('transactionId') ? map['bankName'] : '',
        markedAppendedTrx:
            map.containsKey('appended') ? map['appended'] : false,
        date: map.containsKey('timestamp')
            ? dateTimeFromStamp(map['timestamp'])
            : DateTime.now(),
        receiptSent:
            map.containsKey('receiptSent') ? map['receiptSent'] : false,
        touched: map.containsKey('touched') ? map['touched'] : false,
        customerName:
            map.containsKey('customerName') ? map['customerName'] : '');
  }

  List<TransactionPODO> fromJsonArr(List list) {
    return List<TransactionPODO>.from(
        list.map((x) => TransactionPODO.fromJson(x)));
  }

  @override
  // TODO: implement props
  List<Object?> get props => [date, amount, bankName, bankLogo];
}
