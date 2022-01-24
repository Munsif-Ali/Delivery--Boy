import 'package:deliveryapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart' as my;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  my.User? _userFromFirebaseUser(User user) {
    return user != null ? my.User(uId: user.uid) : null;
  }

  // auth change user stream
  Stream<my.User?> get user {
    return _auth
        .authStateChanges()
        .map((event) => _userFromFirebaseUser(event!));
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print("Error IN SIgn in is" + e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DatabaseServie(uId: user!.uid)
          .updateUserData("new Member", "0349", "Peshawar");
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("Error is" + e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print("From SignOut" + error.toString());
      return null;
    }
  }
}
