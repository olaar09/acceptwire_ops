class ProfilePODO {
  String? displayName;
  String? firstName;
  String? lastName;
  String? phone;
  String? emailAddress;
  String? bvn;
  bool activated;
  bool verified;

  ProfilePODO.setData(
      {this.firstName,
      this.lastName,
      this.phone,
      this.emailAddress,
      this.bvn,
      this.verified = false,
      this.activated = false});

  factory ProfilePODO.fromJson(Map<dynamic, dynamic> map) {
    return ProfilePODO.setData(
        phone: map['Phone'],
        emailAddress: map['Email'],
        firstName: map['FirstName'],
        bvn: map['BVN'],
        verified: map['Verified'],
        activated: map['Activated']);
  }
}
