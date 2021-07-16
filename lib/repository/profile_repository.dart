/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepository {
  final FirebaseFirestore _fireStore;
  final User? user;
  late final CollectionReference _mainCollection;

  ProfileRepository({FirebaseFirestore? fireStore, required this.user})
      : _fireStore = fireStore ?? FirebaseFirestore.instance {
    _mainCollection = _fireStore.collection('profiles');
  }

  Future<void> updateClasses({
    required String title,
    required String description,
  }) async {
    DocumentReference documentReferencer =
    _mainCollection.doc(user!.uid).collection('classes').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "classes": [1, 2, 3],
      "phone": '08104581225',
      "location": "lagos"
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Profile item added to the database"))
        .catchError((e) => print(e));
  }


  Future<void> updateBio({
    required String title,
    required String description,
  }) async {
    DocumentReference documentReferencer =
    _mainCollection.doc(user!.uid).collection('classes').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "phone": '08104581225',
      "location": "lagos"
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Profile item added to the database"))
        .catchError((e) => print(e));
  }

  Stream<QuerySnapshot> readItems() {
    CollectionReference notesItemCollection =
    _mainCollection.doc(user!.uid).collection('items');

    return notesItemCollection.snapshots();
  }
}
*/
