class AuthData {
  String? fullName;
  String? email;
  String? phone;
  String? password;

  factory AuthData.login({email, password}) {
    return AuthData(password: password, email: email);
  }

  factory AuthData.signUp({name, email, password}) {
    return AuthData(password: password, email: email, fullName: name);
  }

  AuthData({this.fullName, this.email, this.password, this.phone});
}
