import 'package:brew_crew/model/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _userfromFirebase(User? user) {
    return user != null ? UserModel(user.uid) : null;
  }

//  SignIn with Email and Password
  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      DataBaseService(uid: user!.uid).userData;
      return _userfromFirebase(user);
    } catch (e) {
      return null;
    }
  }

//register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        DataBaseService(uid: user.uid).updateUserData('0', 100, 'shashank');
      }
      return _userfromFirebase(user);
    } catch (e) {
      return null;
    }
  }

//signout function
  Future signOut() async {
    try {
      await _auth.signOut();
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
