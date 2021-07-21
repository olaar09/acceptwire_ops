import 'package:acceptwire/podo/bank_account_podo.dart';

class ProfilePODO {
  String? displayName;
  String? firstName;
  String? lastName;
  String? phone;
  String? emailAddress;
  String? bvn;
  bool activated;
  bool verified;
  double mainBalance;
  List<BankAccountPODO>? bankAccounts;

  ProfilePODO.setData(
      {this.firstName,
      this.lastName,
      this.phone,
      this.emailAddress,
      this.bvn,
      this.mainBalance = 0,
      this.bankAccounts,
      this.verified = false,
      this.activated = false});

  factory ProfilePODO.fromJson(Map<dynamic, dynamic> map) {
    //print(map);
    return ProfilePODO.setData(
      phone: map['Phone'],
      emailAddress: map['Email'],
      firstName: map['FirstName'],
      lastName: map['LastName'],
      bvn: map['BVN'],
      bankAccounts: map.containsKey('Accounts')
          ? BankAccountPODO().fromJsonArr(map['Accounts'])
          : [],
      mainBalance: double.parse(
          '${map.containsKey('MainBalance') ? map['MainBalance'] : '0'}'),
      verified: map.containsKey('Verified') ? map['Verified'] : false,
      activated: map.containsKey('Activated') ? map['Activated'] : false,
    );
  }
}
