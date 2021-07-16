class AuthData {
  String? firstName;
  String? lastName;
  String? bvnNumber;

  String? email;
  String? phone;
  String? password;

  factory AuthData.login({email, password}) {
    return AuthData(password: password, email: email);
  }

  factory AuthData.signUp(
      {firstName, lastName, bvnNumber, phone, email, password}) {
    return AuthData(
        password: password,
        email: email,
        firstName: firstName,
        lastName: lastName,
        bvnNumber: bvnNumber,
        phone: phone);
  }

  AuthData(
      {this.firstName,
      this.lastName,
      this.bvnNumber,
      this.email,
      this.password,
      this.phone});
}
