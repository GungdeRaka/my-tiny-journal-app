import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService({FirebaseAuth? auth})
    : _firebaseAuth = auth ?? FirebaseAuth.instance;

  Future<UserCredential> createUser(String email, String password) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Terjadi kesalahan saat membuat akun!";
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      // Kita ambil user-nya saja dari dalam result
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Terjadi kesalahan saat login";
    } catch (e) {
      throw "Error tidak diketahui";
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
