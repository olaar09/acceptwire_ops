import 'package:firebase_database/firebase_database.dart';

class FirebaseDBRepo {
  DatabaseReference _reference = FirebaseDatabase.instance.reference();

  DatabaseReference getDataRef({required String reference}) {
    return _reference.child('$reference');
  }
}
