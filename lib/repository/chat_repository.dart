import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatRepository {
  late DatabaseReference _databaseRef; //database reference object
  User? user;

  ChatRepository({required this.user}) {
    var firebaseDb = FirebaseDatabase.instance;
    _databaseRef = firebaseDb.reference();
  }

  void comment({required int assetId, required String comment}) {
    _databaseRef.push().set({'asset_id': assetId, 'comment': comment}).onError(
        (error, stackTrace) => print(error));
  }

  void printFirebase() {
    _databaseRef
        .child('-MdHwRmBecQuxbsB-Lp8')
        .once()
        .then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }
}
