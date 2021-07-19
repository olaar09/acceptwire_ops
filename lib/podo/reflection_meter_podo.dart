class ReflectionMeter {
  String status;
  String reading;

  ReflectionMeter({required this.reading, required this.status});

  factory ReflectionMeter.fromJson(Map<dynamic, dynamic> map) {
    return ReflectionMeter(
      status: map['status'],
      reading: map['message'],
    );
  }
}
