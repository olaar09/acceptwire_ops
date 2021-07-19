class BankAccountPODO {
  late String accountNumber;
  late String bankName;
  late String bankId;
  late String bankLogo;

  BankAccountPODO();

  BankAccountPODO.setData(
      {required this.accountNumber,
      required this.bankName,
      required this.bankId,
      required this.bankLogo});

  factory BankAccountPODO.fromJson(Map<dynamic, dynamic> map) {
    // print(map);
    return BankAccountPODO.setData(
        accountNumber: map['accountNumber'],
        bankName: map['bankName'],
        bankLogo: map['bankLogo'],
        bankId: map['bankId']);
  }

  List<BankAccountPODO> fromJsonArr(List list) {
    return List<BankAccountPODO>.from(
        list.map((x) => BankAccountPODO.fromJson(x)));
  }
}
