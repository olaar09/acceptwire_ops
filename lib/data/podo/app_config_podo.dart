class AppConfig {
  String payStackKey;

  AppConfig({required this.payStackKey});

  factory AppConfig.fromJson(Map<String, dynamic> data) {
    return AppConfig(payStackKey: 'non');
  }
}
