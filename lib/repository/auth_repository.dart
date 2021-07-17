import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<UserCredential> signInWithCredentials(
      String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signUp(
      {required String email, required String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    return _firebaseAuth.currentUser != null;
  }

  Future<User?> getUser() async {
    return _firebaseAuth.currentUser;
  }

  Future<UserCredential> registerUsingEmailPassword(
    String name,
    String email,
    String password,
  ) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<User?> updateDisplayName(String name) async {
    await _firebaseAuth.currentUser!.updateDisplayName(name);
    await _firebaseAuth.currentUser!.reload();
    return _firebaseAuth.currentUser;
  }

  Future<String?> getToken() async {
    if (await isSignedIn())
      try {
        return await _firebaseAuth.currentUser!.getIdToken();
      } catch (e) {
        _firebaseAuth.signOut();
      }
  }
}
