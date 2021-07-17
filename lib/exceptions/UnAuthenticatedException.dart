class UnAuthenticatedException implements Exception {
  final String cause;

  UnAuthenticatedException({required this.cause});
}
